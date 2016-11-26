# coding=utf-8
"""The root of the ``graphs`` namespace."""
import collections
import io
import random
import sys
import textwrap


HalfEdge = collections.namedtuple('HalfEdge', ('dst', 'weight'))

WholeEdge = collections.namedtuple('WholeEdge', ('src', 'dst', 'weight'))


class Graph(object):
    """A graph with weighted, directed edges."""

    def __init__(self):
        # A dict in the form {vertex, [HalfEdge, HalfEdge, …]}
        self.vertices = {}

        # A monotonic counter, incremented each time this graph is modified.
        # Overflows are OK.
        self._modified = 0

        # The stronly connected components of this graph. A list of lists of
        # vertices, in the form [[v1, v2], [v3], …].
        self._components = None
        self._components_made = None

    def add_vertex(self, vertex):
        """Add a vertex to this graph."""
        self.vertices.setdefault(vertex, [])
        self._modified += 1

    def add_edge(self, src_vertex, dst_vertex, weight):
        """Add an edge to this graph."""
        self.add_vertex(src_vertex)
        self.add_vertex(dst_vertex)
        self.vertices[src_vertex].append(HalfEdge(dst_vertex, int(weight)))
        self._modified += 1

    def read_file(self, file_):
        """Populate this graph from a file."""
        with open(file_, encoding='ascii') as handle:
            for line in handle.read().splitlines():
                self.add_edge(*line.split())

    def get_edges(self):
        """Yield the edges in this graph, as :class:`WholeEdge`."""
        for vertex, edges in self.vertices.items():
            for edge in edges:
                yield WholeEdge(vertex, edge.dst, edge.weight)

    def get_components(self):
        """Get the strongly connected components of this graph.

        Calculate the strongly connected components of this graph only if
        needed. Return a list of lists of vertices, in the form ``[[v1, v2],
        [v3], …]``.
        """
        if self._components_made != self._modified:
            self._components = tarjan(self)
            self._components_made = self._modified
        return self._components

    def get_component_graph(self):
        """Get a DAG from this graph's strongly connected components.

        Generate a DAG from this graph's strongly connected components only if
        needed. Return the generated :class:`Graph`.

        Each of this graph's strongly connected components is represented as a
        single vertex in the returned graph. If two or more edges connect a
        component, and if those edges pass in the same direction, only the
        lowest weight edge is kept. (If two edges have the same weight, one is
        arbitrarily kept.)
        """
        components = self.get_components()

        # Create a dict in the form {vertex: component_name}.
        owners = {}
        for component in components:
            component.sort()
            component_name = ', '.join(vertex for vertex in component)
            for vertex in component:
                owners[vertex] = component_name

        # Find the edges between components. Ignore the edges inside each
        # component.
        component_edges = []
        for full_edge in self.get_edges():
            src_vertex = owners[full_edge.src]
            dst_vertex = owners[full_edge.dst]
            if src_vertex != dst_vertex:
                component_edges.append(
                    WholeEdge(src_vertex, dst_vertex, full_edge.weight)
                )

        # Deduplicate the edges between components.
        self._dedup_edges(component_edges)

        # Build and return a graph of strongly connected components.
        graph = Graph()
        for component_edge in component_edges:
            graph.add_edge(*component_edge)
        return graph

    def to_prose(self):
        """Return a prose description of this graph."""
        full_graph_components = self.get_components()
        full_graph_mst_edges = get_component_msts(self)

        comp_graph = self.get_component_graph()
        comp_graph_components = comp_graph.get_components()
        comp_graph_mst_edges = prim(comp_graph, comp_graph_components[-1][0])

        # `wrapper` can also indent text. It's especially useful for bulleted
        # lists that are expected to span multiple lines. In this case, the
        # bulleted items are unlikely to span multiple lines, so the effort is
        # not taken to use `wrapper` for such. Wouldn't hurt, though. :-/
        wrapper = textwrap.TextWrapper()
        with io.StringIO() as handle:

            handle.write(wrapper.fill(
                'The edges in each component are as follows:'
            ))
            handle.write('\n\n')
            for component in full_graph_components:
                handle.write('* ' + ', '.join(component) + '\n')
            handle.write('\n')

            handle.write(wrapper.fill(textwrap.dedent(
                '''The edges in a minimum spanning tree of strongly connected
                components are as follows:'''
            )))
            handle.write('\n\n')
            for edge in comp_graph_mst_edges:
                handle.write(
                    '* {} -> {} ({})\n'.format(edge.src, edge.dst, edge.weight)
                )
            handle.write('\n')

            handle.write(wrapper.fill(textwrap.dedent(
                '''The edges in minimum spanning trees of each strongly
                connected component are as follows:'''
            )))
            handle.write('\n\n')
            for edge_group in full_graph_mst_edges:
                handle.write('Group:\n')
                if len(edge_group) == 0:
                    handle.write('* (no edges)\n')
                for edge in edge_group:
                    handle.write(
                        '* {} -> {} ({})\n'
                        .format(edge.src, edge.dst, edge.weight)
                    )

            return handle.getvalue()

    def to_dot(self, highlight=None):
        """Return a DOT description of this graph.

        The DOT description returned by this method is not complete. Use this
        method like so::

            dot = 'digraph foo {\n\n' + graph.to_dot() + '}\n'

        ``highlight`` is an iterable of :class:`WholeEdge` objects. If present,
        each edge given is highlighted. This parameter is useful if one wants
        to highlight the edges comprising a minimum spanning tree.
        """
        if highlight is None:
            highlight = []
        with io.StringIO() as handle:

            handle.write('// Declare edges.\n')
            for vertex, edges in self.vertices.items():
                for edge in edges:
                    handle.write('"{}" -> "{}" '.format(vertex, edge.dst))
                    handle.write('[label="weight: {}" '.format(edge.weight))
                    if WholeEdge(vertex, edge.dst, edge.weight) in highlight:
                        handle.write('color=red')
                    handle.write(']\n')
            handle.write('\n')

            handle.write('//Declare strongly connected components.\n')
            for component in self.get_components():
                # NOTE: The subgraph name must start with "cluster". Otherwise,
                # graphviz will ignore it.
                handle.write('subgraph cluster_{} {{\n'.format(id(component)))
                handle.write('style=filled;\ncolor=lightgrey;\n')
                for vertex in component:
                    handle.write('"{}";\n'.format(vertex))
                handle.write('}\n')
            handle.write('\n')

            return handle.getvalue()

    @staticmethod
    def _dedup_edges(edges):
        """Deduplicate edges betweeen vertices.

        Search for pairs of edges with the same source and destination
        vertices. For each such pair, remove the higher weighted edge.

        :param edges: A list of :class:`WholeEdge` objects.
        :returns: Nothing. The list of edges is modified in place.
        """
        # Sort by src, then dest, then weight. See:
        # https://docs.python.org/3.5/howto/sorting.html#sort-stability-and-complex-sorts
        edges.sort(key=lambda edge: edge.weight)
        edges.sort(key=lambda edge: edge.dst)
        edges.sort(key=lambda edge: edge.src)

        # Due to sorting order, the first edge between any two vertices is best
        i = 0
        while i < len(edges) - 1:
            if (edges[i].src == edges[i + 1].src and
                    edges[i].dst == edges[i + 1].dst):
                del edges[i + 1]
            else:
                i += 1


def prim(graph, start=None):
    """Prim's minimum spanning tree algorithm.

    Return an iterable of :class:`WholeEdge` objects.

    If a ``start`` vertex is given, use it as the root of the minimum spanning
    tree. Otherwise, use a random vertex as the root. Choosing a correct
    starting node is important. For example, a graph of strongly connected
    components forms a DAG, and if such a graph is passed in, then the root of
    the DAG should be chosen as the ``start`` vertex.
    """
    # Choose a starting vertex.
    if start is None:
        start = random.sample(graph.vertices.keys(), 1)[0]

    # Create a queue of vertices, where each vertex has a distance and a
    # parent. The queue is in the form {vertex: prim_vertex}.
    queue = collections.OrderedDict()
    for vertex in graph.vertices:
        queue[vertex] = PrimVertex(distance=sys.maxsize, parent=None)
    queue[start].distance = 0

    # Repeatedly pick the lowest-distance vertices off the queue. The choices
    # are in the form {vertex: prim_vertex}.
    choices = {}
    while queue:
        queue = collections.OrderedDict(sorted(
            queue.items(),
            key=lambda item: item[1].distance
        ))
        vertex, prim_vertex = queue.popitem(last=False)
        choices[vertex] = prim_vertex

        # For each neighbor of the chosen vertex, maybe update its distance and
        # parent.
        for edge in graph.vertices[vertex]:
            # edge.dst is a neighboring vertex
            if edge.dst in queue and queue[edge.dst].distance > edge.weight:
                queue[edge.dst].distance = edge.weight
                queue[edge.dst].parent = vertex
    del choices[start]  # The root of the MST has no parent.

    # Create an iterable of edges.
    return [
        WholeEdge(prim_vertex.parent, vertex, prim_vertex.distance)
        for vertex, prim_vertex in choices.items()
    ]


class PrimVertex(object):  # pylint:disable=too-few-public-methods
    # This class is a simple mutable container for data. We don't care how many
    # methods it has.
    """The distance to and parent of a vertex."""

    def __init__(self, distance, parent):
        self.distance = distance
        self.parent = parent


def get_component_msts(graph):
    """Given a graph, calculate a minimum spanning tree for each component.

    Return a list of lists, where each list contains the edges in a component.
    The data structure looks like so::

        [[WholeEdge, WholeEdge], [], [WholeEdge], …]

    The lists may be collapsed with ``itertools.chain.from_iterable``.
    """
    # Create a dict in the form {vertex: component}.
    owners = {}
    components = graph.get_components()
    for component in components:
        for vertex in component:
            owners[vertex] = component

    # Find edges whose source and destination are in the same component.
    edge_groups = {}  # {component_id: [whole_edge, …]}
    for whole_edge in graph.get_edges():
        src_component = owners[whole_edge.src]
        dst_component = owners[whole_edge.dst]
        if src_component == dst_component:
            edge_groups.setdefault(id(src_component), []).append(whole_edge)

    # Calculate MSTs for each component.
    mst_edges = []
    for edge_group in edge_groups.values():
        graph = Graph()
        for edge in edge_group:
            graph.add_edge(edge.src, edge.dst, edge.weight)
        mst_edges.append(prim(graph))
    return mst_edges


def tarjan(graph):
    """Tarjan's strongly connected components algorithm.

    Return a list of lists, where each inner list contains the vertices in a
    strongly connected graph component.

    See:
    https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm
    """
    return _Tarjan(graph).components


class _Tarjan(object):  # pylint:disable=too-few-public-methods
    """Tarjan's strongly connected components algorithm.

    .. NOTE: Do not use this class directly. Use :meth:`tarjan` instead.
    """

    def __init__(self, graph):
        self.graph = graph
        self.stack = []  # a stack of vertices
        self.components = []

        # A monotonically increasing counter. Each time a vertex is discovered,
        # the counter's current value is "written" on the vertex, and the
        # counter is incremented.
        self.counter = 0

        # Each dict maps vertices to vertex metadata. `discovered` tracks when
        # each vertex was discovered. `reachable` tracks the lowest-numbered
        # vertex each vertex can reach, with the restriction that only vertices
        # in the stack are candidates.
        #
        # As Tarjan's algorithm progresses, there are always (logically) an
        # equal number of entries in each dict. When Tarjan's algorithm
        # finishes, each dict contains one entry per vertex.
        self.discovered = {}
        self.reachable = {}

        for vertex in self.graph.vertices:
            if vertex not in self.discovered:
                self._connect(vertex)

    def _connect(self, vertex):
        """Find the strongly connected components reachable from ``vertex``."""
        self.stack.append(vertex)
        self.discovered[vertex] = self.counter
        self.reachable[vertex] = self.counter
        self.counter += 1

        # Consider the given vertex's neighbors.
        for edge in self.graph.vertices[vertex]:
            if edge.dst not in self.discovered:
                self._connect(edge.dst)
                self.reachable[vertex] = min(
                    self.reachable[vertex],
                    self.reachable[edge.dst],
                )
            elif edge.dst in self.stack:  # and neighbor has been discovered
                # This neighbor is part of the current DFS and, therefore, the
                # current strongly connected component.
                self.reachable[vertex] = min(
                    self.reachable[vertex],
                    self.discovered[edge.dst],
                )
            # elif neighbor not in stack and neighbor has been discovered:
            #     The neighbor was discovered during a past DFS, not the
            #     current DFS. We don't care which nodes it can reach, as it
            #     cannot be part of the current strongly connected component.

        # `vertex` is the root of the current DFS. But is it also the root
        # vertex used to discover a strongly connected component? If so, pop
        # the stack starting at `vertex`.
        if self.discovered[vertex] == self.reachable[vertex]:
            component = [self.stack.pop()]
            while component[-1] != vertex:
                component.append(self.stack.pop())
            self.components.append(component)
