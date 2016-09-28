# coding=utf-8
"""The classes necessary to implement an interval tree."""
import io

from interval_tree.exceptions import InvalidIntervalError, NoSuchIntervalError

BLACK = object()
"""A possible value for a ``Node`` object's ``color`` attribute."""

RED = object()
"""A possible value for a ``Node`` object's ``color`` attribute."""


class IntervalTree(object):
    """An ordered tree of intervals.

    An interval tree is an augmented red-black tree, where each node contains
    an interval. Each interval has an ordered pair of attributes, ``low`` and
    ``high``, which are comparable. The exact nature of the data doesn't
    matter. The intervals could be pairs of integers, pairs of naive date-time
    objects, version numbers, or so on.

    The exact implementation of the tree is protected.
    """

    def __init__(self):
        self._root = None

    def _insert_fixup(self, node):
        """Perform fix-up operations after ``insert`` has been called.

        This algorithm is mostly transcribed from Introduction to Algorithms,
        Third Edition, by Cormen etc., section 13.3. (Red-Black Trees →
        Insertion) The book defines a fix-up procedure for red-black interval
        trees, and this implementation also maintains the `max` attribute.

        Our strategy is this: whenever we walk from a node to its parent, we
        update the parent's `max` attribute. The rotation functions clean up
        after themselves. When the fixup has finished, we may not be at the
        root yet, so we address this with an extra loop.

        An alternate strategy is to wait until the fixup is complete, and
        then walk from the inserted node to the root all over again, fixing
        `max` attributes as we go. Though this is straightforward, the author
        finds this harder to (informally) prove correct. In addition, this
        approach ignores locality, and may be less performant for large trees.
        """
        while self.color(node.parent) is RED:
            if node.parent is node.parent.parent.left:
                uncle = node.parent.parent.right
                if self.color(uncle) is RED:
                    node.parent.color = BLACK
                    uncle.color = BLACK
                    node.parent.parent.color = RED
                    for _ in range(2):
                        node = node.parent
                        self._set_max(node)
                else:
                    if node is node.parent.right:
                        node = node.parent
                        self._set_max(node)
                        self._rotate_left(node)
                    node.parent.color = BLACK
                    node.parent.parent.color = RED
                    self._rotate_right(node.parent.parent)
            else:
                uncle = node.parent.parent.left
                if self.color(uncle) is RED:
                    node.parent.color = BLACK
                    uncle.color = BLACK
                    node.parent.parent.color = RED
                    for _ in range(2):
                        node = node.parent
                        self._set_max(node)
                else:
                    if node is node.parent.left:
                        node = node.parent
                        self._set_max(node)
                        self._rotate_right(node)
                    node.parent.color = BLACK
                    node.parent.parent.color = RED
                    self._rotate_left(node.parent.parent)
        while node.parent is not None:
            node = node.parent
            self._set_max(node)
        node.color = BLACK  # root node

    def _rotate_left(self, node):
        """Perform a left rotation.

        Rotating "x" left produces the following transformation::

             r         r
             │         │
             x         y
            ┌┴┐   →   ┌┴┐
            a y       x c
             ┌┴┐     ┌┴┐
             b c     a b

        Node colors are not adjusted.
        """
        # Variable names are taken from the sample above. "x" and "y" are
        # assumed to be non-null. All others may be null.
        node_x = node
        node_y = node_x.right

        # Link x and b
        node_x.right = node_y.left
        if node_x.right is not None:
            node_x.right.parent = node_x

        # Link r and y
        node_y.parent = node_x.parent
        if node_x.parent is None:
            self._root = node_y
        elif node_x.parent.left is node_x:  # compare identity, not equality
            node_x.parent.left = node_y
        else:
            node_x.parent.right = node_y

        # link y and x
        node_y.left = node_x
        node_x.parent = node_y

        # Update x.max and y.max. No other nodes can change.
        self._set_max(node_x)
        self._set_max(node_y)

    def _rotate_right(self, node):
        """Perform a right rotation.

        Rotating "y" right produces the following transformation::

              r       r
              │       │
              y       x
             ┌┴┐  →  ┌┴┐
             x c     a y
            ┌┴┐       ┌┴┐
            a b       b c

        Node colors are not adjusted.
        """
        # Variable names are taken from the sample above. "x" and "y" are
        # assumed to be non-null. All others may be null.
        node_y = node
        node_x = node_y.left

        # Link y and b
        node_y.left = node_x.right
        if node_y.left is not None:
            node_y.left.parent = node_y

        # Link r and x
        node_x.parent = node_y.parent
        if node_y.parent is None:
            self._root = node_x
        elif node_y.parent.left is node_y:  # compare identity, not equality
            node_y.parent.left = node_x
        else:
            node_y.parent.right = node_x

        # link x and y
        node_x.right = node_y
        node_y.parent = node_x

        # Update x.max and y.max. No other nodes can change.
        self._set_max(node_x)
        self._set_max(node_y)

    @staticmethod
    def _set_max(node):
        """Update a node's ``max`` attribute."""
        candidates = {node.interval.high}
        for child in node.left, node.right:
            if child is not None:
                candidates.add(child.max)
        node.max = max(candidates)

    def as_dot(self):
        """Return a DOT script describing this tree, as a string.

        The returned script is not a full digraph. It may be turned into one
        like so::

            '\n'.join(('digraph foo {', as_dot(), '}'))
        """
        handle = io.StringIO()  # "file handle"
        current = self.min()
        while True:
            handle.write('{} [label="{}\\n{}" color={}]\n'.format(
                id(current),
                current.interval,
                current.max,
                'red' if current.color is RED else 'black',
            ))
            if current.parent is not None:
                handle.write(
                    '{} -> {}\n'.format(id(current), id(current.parent))
                )
            if current.left is not None:
                handle.write(
                    '{} -> {}\n'.format(id(current), id(current.left))
                )
            if current.right is not None:
                handle.write(
                    '{} -> {}\n'.format(id(current), id(current.right))
                )
            try:
                current = self.next(current)
            except NoSuchIntervalError:
                break
        handle.write(
            '{} [style=filled, fillcolor=yellow]'.format(id(self._root))
        )
        script = handle.getvalue()
        handle.close()
        return script

    @staticmethod
    def color(node):
        """Tell the color of a node.

        If the given node is ``None``, return ``BLACK``. (All leaves are black,
        as is the parent of the root node.) Otherwise, return ``node.color``.
        """
        if node is None:
            return BLACK
        return node.color

    def insert(self, node):
        """Insert the given ``node`` into the tree."""
        prev = None
        current = self._root
        while current is not None:
            prev = current
            if node.interval.low < current.interval.low:
                current = current.left
            else:
                current = current.right
        node.parent = prev
        if prev is None:
            self._root = node  # tree was empty
        elif node.interval.low < prev.interval.low:
            prev.left = node
        else:
            prev.right = node
        node.color = RED
        self._insert_fixup(node)

    def min(self, node=None):
        """Find the minimum node in the tree, relative to the given node.

        If the given node is the minimum node, return the given node.

        If no node is given, search relative to the root node. If no node is
        given and the tree is empty, raise
        ``interval_tree.exceptions.NoSuchIntervalError``.
        """
        if node is None:
            current = self._root
        else:
            current = node
        if current is None:
            raise NoSuchIntervalError
        while current.left is not None:
            current = current.left
        return current

    def next(self, node):
        """Find the next node in the tree, after the given ``node``.

        Raise ``interval_tree.exceptions.NoSuchIntervalError`` if the given
        node is the maximum node.
        """
        if node.right is not None:
            return self.min(node.right)
        while node.parent is not None and node is node.parent.right:
            node = node.parent

        # Either we're a left child of a node, or the parent is nil and there
        # is no next node.
        if node.parent is None:
            raise NoSuchIntervalError
        return node.parent

    def overlapping_intervals(self, interval):
        """Find all intervals that overlap with the given interval."""
        return self._overlapping_intervals(interval, self._root)

    @classmethod
    def _overlapping_intervals(cls, interval, node):
        """Find all intervals that overlap with the given interval.

        Search ``node`` and all of its descendant nodes.
        """
        if node is None:
            return []

        # check current node
        if node.interval.overlaps(interval):
            matches = [node.interval]
        else:
            matches = []

        # check right tree
        if interval < node.interval:
            right_matches = []  # skip tree
        else:
            right_matches = cls._overlapping_intervals(interval, node.right)

        # check left tree
        if node.left is not None and node.left.max < interval.low:
            left_matches = []  # skip tree
        else:
            left_matches = cls._overlapping_intervals(interval, node.left)

        return left_matches + matches + right_matches


# Node objects could be implemented as a generic mutable data container, like a
# dict. But using proper objects allows for better linting.
class Node(object):  # pylint:disable=too-few-public-methods
    """A node in an ``IntervalTree``.

    The following properties are available for use by clients:

    interval
        Some ordered pair of values, as an ``Interval`` object.
    parent
        The parent of this node.
    left
        The left child of this node.
    right
        The right child of this node.
    max
        The maximum of ``interval.high``, ``left.max`` and ``right.max``.
    color
        Either ``BLACK`` or ``RED``. Defaults to ``BLACK``.

    Nodes are comparable with all of the rich comparison methods (e.g. ``<``),
    based on their ``interval.low attribute. Note that this is **not** a good
    way to compare intervals to each other, and comparisons are implemented
    this way because ``IntervalTree`` uses ``interval.low`` as a sorting key.
    (Intervals should be compared with the interval trichotomy in mind.)
    """

    def __init__(self, interval):
        self.interval = interval
        self.parent = None
        self.left = None
        self.right = None
        self.color = BLACK
        self.max = self.interval.high

    def __lt__(self, other):
        if self.interval.low < other.interval.low:
            return True
        return False

    def __le__(self, other):
        if self.interval.low <= other.interval.low:
            return True
        return False

    def __eq__(self, other):
        if self.interval.low == other.interval.low:
            return True
        return False

    def __ge__(self, other):
        if self.interval.low >= other.interval.low:
            return True
        return False

    def __gt__(self, other):
        if self.interval.low > other.interval.low:
            return True
        return False


class Interval(object):  # pylint:disable=too-few-public-methods
    """An ordered pair of values.

    The two values may be any comparable pair of values, so long as ``low`` <=
    ``high``. If ``low`` > ``high`, raise
    ``interval_tree.exceptions.InvalidIntervalError``.
    """

    def __init__(self, low, high):
        if low > high:
            raise InvalidIntervalError
        self.low = low
        self.high = high

    def __str__(self):
        return '[{}, {}]'.format(self.low, self.high)

    def __lt__(self, other):
        if self.high < other.low:
            return True
        return False

    def __gt__(self, other):
        if other.high < self.low:
            return True
        return False

    def overlaps(self, other):
        """Return true if this node overlaps with ``other``.

        Two intervals are considered overlapping if any value may be placed
        into both intervals at the same time. Intervals are considered
        inclusive. The following intervals overlap:

        * [1, 2] and [1, 2]
        * [1, 2] and [1, 3]
        * [1, 2] and [2, 3]

        The following intervals do not overlap:

        * [1, 2] and [3, 4]
        """
        if self.high < other.low or self.low > other.high:
            return False
        return True
