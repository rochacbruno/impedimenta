package dag_sorter;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;

public class Graph {
    HashMap<Integer, Node> nodes;

    /**
     * Creates an empty graph.
     */
    public Graph() {
        nodes = new HashMap<Integer, Node>();
    }

    /**
     * Adds an edge to this graph. Creates <code>src</code> and <code>dest
     * </code> nodes to the graph if necessary.
     */
    public void addEdge(Integer src, Integer dest) {
        if(! nodes.containsKey(src)) {
            nodes.put(src, new Node(src));
        }
        if(! nodes.containsKey(dest)) {
            nodes.put(dest, new Node(dest));
        }

        nodes.get(src).outEdges.put(dest, nodes.get(dest));
        nodes.get(dest).inEdges.put(src, nodes.get(src));
    }

    /**
     * Returns a topologically sorted array of nodes in this graph.
     */
    public Node[] sortNodes() {
        // Nodes which have no outgoing edges.
        Vector<Node> sinkNodes = new Vector<Node>();
        // The topologically sorted list of nodes.
        Vector<Node> sortedNodes = new Vector<Node>();

        // Populate sinkNodes.
        Set<Integer> keys = nodes.keySet();
        for(Iterator<Integer> iter = keys.iterator(); iter.hasNext();) {
            Integer key = iter.next();
            if(0 == nodes.get(key).outEdges.size()) {
                sinkNodes.add(nodes.get(key));
            }
        }

        // Populate sortedNodes.
        for(int i = 0; i < sinkNodes.size(); i++) {
            visitNode(sinkNodes.get(i), sortedNodes);
        }

        // Set all the nodes to the "not visited" state.
        keys = nodes.keySet();
        for(Iterator<Integer> iter = keys.iterator(); iter.hasNext();) {
            Integer key = iter.next();
            nodes.get(key).visited = false;
        }

        return sortedNodes.toArray(new Node[0]);
    }

    /**
     * Visits all nodes leading to <code>node</code>, then appends each of those
     * nodes to <code>sortedNodes</code>. Useful for topologically sorting a
     * directed acyclic graph.
     *
     * A depth-first algorithm is used. If this <code>node</code> has not yet
     * been visited:
     * 1. mark <code>node</code> as visited
     * 2. recursively visit each node in <code>node.inEdges</code>
     * 3. append <code>node</code> to <code>sortedNodes </code>
     */
    private void visitNode(Node node, Vector<Node> sortedNodes) {
        if(true == node.visited)
            return;

        node.visited = true;
        Set<Integer> keys = node.inEdges.keySet();
        for(Iterator<Integer> iter = keys.iterator(); iter.hasNext();) {
            Integer key = iter.next();
            visitNode(node.inEdges.get(key), sortedNodes);
        }
        sortedNodes.add(node);
    }

    /**
     * A String representation of this graph. Returns the IDs of each <code>Node
     * </code> in this <code>Graph</code>.
     */
    @Override
    public String toString() {
        if(0 == nodes.size()) {
            return "";
        }

        String repr = "";
        Set<Integer> keys = nodes.keySet();
        for(Iterator<Integer> iter = keys.iterator(); iter.hasNext();) {
            Integer key = iter.next();
            repr += nodes.get(key).toString() + ", ";
        }
        repr = repr.split(", $")[0]; // strip trailing ", "
        return repr;
    }
}
