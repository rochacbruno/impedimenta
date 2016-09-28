# coding=utf-8
"""Unit tests for this application."""
import unittest

from interval_tree.classes import Interval, IntervalTree, Node
from interval_tree.exceptions import InvalidIntervalError, NoSuchIntervalError


class IntervalTreeMinTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.IntervalTree.min``."""

    def test_no_nodes(self):
        """Search through an empty tree."""
        tree = IntervalTree()
        with self.assertRaises(NoSuchIntervalError):
            tree.min()

    def test_one_node(self):
        """Search through a tree with one node."""
        node = Node(Interval(1, 1))
        tree = IntervalTree()
        tree.insert(node)
        with self.subTest(comment='pass nothing'):
            self.assertEqual(tree.min(), node)
        with self.subTest(comment='pass node'):
            self.assertEqual(tree.min(node), node)

    def test_three_nodes(self):
        """Search through a tree with three nodes.

        The nodes are organized as such::

              a
            ┌─┘
            b
            └┐
             c
        """
        tree = IntervalTree()
        node_a = Node(Interval(3, 3))
        node_b = Node(Interval(1, 1))
        node_c = Node(Interval(2, 2))
        tree.insert(node_a)
        tree.insert(node_b)
        node_b.right = node_c  # force tree to take desired shape
        node_c.parent = node_b
        with self.subTest(comment='pass nothing'):
            self.assertEqual(tree.min(), node_b)
        with self.subTest(comment='pass node_a'):
            self.assertEqual(tree.min(node_a), node_b)
        with self.subTest(comment='pass node_b'):
            self.assertEqual(tree.min(node_b), node_b)
        with self.subTest(comment='pass node_c'):
            self.assertEqual(tree.min(node_c), node_c)


class IntervalTreeNextTestCase(unittest.TestCase):
    """Test interval_tree.classes.IntervalTree.next``."""

    def test_five_nodes(self):
        """Walk through a tree with five nodes.

        The nodes are organized as such::

              c
            ┌─┴─┐
            a   e
            └┐ ┌┘
             b d
        """
        tree = IntervalTree()
        node_a = Node(Interval(1, 1))
        node_b = Node(Interval(2, 2))
        node_c = Node(Interval(3, 3))
        node_d = Node(Interval(4, 4))
        node_e = Node(Interval(5, 5))
        for node in (node_c, node_a, node_e, node_b, node_d):
            tree.insert(node)
        self.assertEqual(tree.next(node_a), node_b)
        self.assertEqual(tree.next(node_b), node_c)
        self.assertEqual(tree.next(node_c), node_d)
        self.assertEqual(tree.next(node_d), node_e)
        with self.assertRaises(NoSuchIntervalError):
            tree.next(node_e)


class IntervalTreeRotateLeftTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.IntervalTree._rotate_left``."""

    def test_empty(self):
        """Rotate a tree consisting of just two nodes.

        The transformation is as such::

             x         y
             └┐   →   ┌┘
              y       x
        """
        tree = IntervalTree()
        node_x = Node(Interval(1, 1))  # current tree root
        node_y = Node(Interval(2, 2))  # future tree root
        tree.insert(node_x)
        tree.insert(node_y)
        tree._rotate_left(node_x)  # pylint:disable=protected-access
        with self.subTest(comment='verify node_x'):
            self.assertEqual(node_x.parent, node_y)
            self.assertIsNone(node_x.left)
            self.assertIsNone(node_x.right)
        with self.subTest(comment='verify node_y'):
            self.assertIsNone(node_y.parent)
            self.assertEqual(node_y.left, node_x)
            self.assertIsNone(node_y.right)

    def test_full(self):
        """Rotate a fully-populated tree.

        The transformation is as such::

            r         r
            └┐        └┐
             x         y
            ┌┴┐   →   ┌┴┐
            a y       x c
             ┌┴┐     ┌┴┐
             b c     a b
        """
        tree = IntervalTree()
        node_r = Node(Interval(1, 1))
        node_a = Node(Interval(2, 2))
        node_x = Node(Interval(3, 3))
        node_b = Node(Interval(4, 4))
        node_y = Node(Interval(5, 5))
        node_c = Node(Interval(6, 6))
        tree.insert(node_r)
        tree.insert(node_x)

        # force tree to take desired shape
        node_x.left = node_a
        node_x.right = node_y
        node_a.parent = node_x
        node_y.parent = node_x
        node_y.left = node_b
        node_y.right = node_c
        node_b.parent = node_y
        node_c.parent = node_y

        tree._rotate_left(node_x)  # pylint:disable=protected-access
        with self.subTest(comment='verify node_r'):
            self.assertIsNone(node_r.parent)
            self.assertIsNone(node_r.left)
            self.assertEqual(node_r.right, node_y)
        with self.subTest(comment='verify node_x'):
            self.assertEqual(node_x.parent, node_y)
            self.assertEqual(node_x.left, node_a)
            self.assertEqual(node_x.right, node_b)
        with self.subTest(comment='verify node_y'):
            self.assertEqual(node_y.parent, node_r)
            self.assertEqual(node_y.left, node_x)
            self.assertEqual(node_y.right, node_c)
        with self.subTest(comment='verify node_a'):
            self.assertEqual(node_a.parent, node_x)
            self.assertIsNone(node_a.left)
            self.assertIsNone(node_a.right)
        with self.subTest(comment='verify node_b'):
            self.assertEqual(node_b.parent, node_x)
            self.assertIsNone(node_b.left)
            self.assertIsNone(node_b.right)
        with self.subTest(comment='verify node_c'):
            self.assertEqual(node_c.parent, node_y)
            self.assertIsNone(node_c.left)
            self.assertIsNone(node_c.right)


class IntervalTreeRotateRightTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.IntervalTree._rotate_right``."""

    def test_empty(self):
        """Rotate a tree consisting of just two nodes.

        The transformation is as such::

              y       x
             ┌┘   →   └┐
             x         y
        """
        tree = IntervalTree()
        node_y = Node(Interval(2, 2))  # current tree root
        node_x = Node(Interval(1, 1))  # future tree root
        tree.insert(node_y)
        tree.insert(node_x)
        tree._rotate_right(node_y)  # pylint:disable=protected-access
        with self.subTest(comment='verify node_x'):
            self.assertIsNone(node_x.parent)
            self.assertIsNone(node_x.left)
            self.assertEqual(node_x.right, node_y)
        with self.subTest(comment='verify node_y'):
            self.assertEqual(node_y.parent, node_x)
            self.assertIsNone(node_y.left)
            self.assertIsNone(node_y.right)

    def test_full(self):
        """Rotate a fully-populated tree.

        The transformation is as such::

              r       r
              │       │
              y       x
             ┌┴┐  →  ┌┴┐
             x c     a y
            ┌┴┐       ┌┴┐
            a b       b c
        """
        tree = IntervalTree()
        node_r = Node(Interval(1, 1))
        node_a = Node(Interval(2, 2))
        node_x = Node(Interval(3, 3))
        node_b = Node(Interval(4, 4))
        node_y = Node(Interval(5, 5))
        node_c = Node(Interval(6, 6))
        tree.insert(node_r)
        tree.insert(node_y)

        # force tree to take desired shape
        node_y.left = node_x
        node_y.right = node_c
        node_x.parent = node_y
        node_x.left = node_a
        node_x.right = node_b
        node_c.parent = node_y
        node_a.parent = node_x
        node_b.parent = node_x

        tree._rotate_right(node_y)  # pylint:disable=protected-access
        with self.subTest(comment='verify node_r'):
            self.assertIsNone(node_r.parent)
            self.assertIsNone(node_r.left)
            self.assertEqual(node_r.right, node_x)
        with self.subTest(comment='verify node_y'):
            self.assertEqual(node_y.parent, node_x)
            self.assertEqual(node_y.left, node_b)
            self.assertEqual(node_y.right, node_c)
        with self.subTest(comment='verify node_x'):
            self.assertEqual(node_x.parent, node_r)
            self.assertEqual(node_x.left, node_a)
            self.assertEqual(node_x.right, node_y)
        with self.subTest(comment='verify node_a'):
            self.assertEqual(node_a.parent, node_x)
            self.assertIsNone(node_a.left)
            self.assertIsNone(node_a.right)
        with self.subTest(comment='verify node_b'):
            self.assertEqual(node_b.parent, node_y)
            self.assertIsNone(node_b.left)
            self.assertIsNone(node_b.right)
        with self.subTest(comment='verify node_c'):
            self.assertEqual(node_c.parent, node_y)
            self.assertIsNone(node_c.left)
            self.assertIsNone(node_c.right)


class NodeComparisonTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.Node`` ordering logic."""

    @classmethod
    def setUpClass(cls):
        """Provide a common target value for all test methods."""
        cls.target = Node(Interval(2, 9))

    def test_less_than(self):
        """Verify the ``<`` operator."""
        self.assertTrue(Node(Interval(1, 9)) < self.target)
        self.assertFalse(Node(Interval(2, 9)) < self.target)
        self.assertFalse(Node(Interval(3, 9)) < self.target)

    def test_less_equal(self):
        """Verify the ``<=`` operator."""
        self.assertTrue(Node(Interval(1, 9)) <= self.target)
        self.assertTrue(Node(Interval(2, 9)) <= self.target)
        self.assertFalse(Node(Interval(3, 9)) <= self.target)

    def test_equal(self):
        """Verify the ``==`` operator."""
        self.assertNotEqual(Node(Interval(1, 9)), self.target)
        self.assertEqual(Node(Interval(2, 9)), self.target)
        self.assertNotEqual(Node(Interval(3, 9)), self.target)

    def test_greater_equal(self):
        """Verify the ``>=`` operator."""
        self.assertFalse(Node(Interval(1, 9)) >= self.target)
        self.assertTrue(Node(Interval(2, 9)) >= self.target)
        self.assertTrue(Node(Interval(3, 9)) >= self.target)

    def test_greater_than(self):
        """Verify the ``>`` operator."""
        self.assertFalse(Node(Interval(1, 9)) > self.target)
        self.assertFalse(Node(Interval(2, 9)) > self.target)
        self.assertTrue(Node(Interval(3, 9)) > self.target)


class IntervalTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.Interval`` dunderscore methods."""

    def test_init_bounds(self):
        """Pass invalid bounds to the constructor.

        Assert an ``interval_tree.exceptions.InvalidIntervalError`` is raised.
        """
        Interval(1, 2)
        Interval(2, 2)
        with self.assertRaises(InvalidIntervalError):
            Interval(3, 2)

    def test_less_than(self):
        """Verify the ``<`` operator."""
        self.assertTrue(Interval(1, 2) < Interval(3, 4))
        self.assertFalse(Interval(1, 3) < Interval(3, 4))

    def test_greater_than(self):
        """Verify the ``>`` operator."""
        self.assertTrue(Interval(3, 4) > Interval(1, 2))
        self.assertFalse(Interval(2, 4) > Interval(1, 2))


class IntervalOverlapsTestCase(unittest.TestCase):
    """Test ``interval_tree.classes.Interval.overlaps``."""

    def test_false(self):
        """Verify that non-overlapping intervals are considered as such."""
        target = Interval(3, 4)
        for low, high in ((1, 2), (5, 6)):
            with self.subTest(interval=(low, high)):
                self.assertFalse(target.overlaps(Interval(low, high)))

    def test_true(self):
        """Verify that oerlapping intervals are considered as such."""
        target = Interval(3, 4)
        for low, high in ((2, 3), (3, 3), (3, 4), (4, 4), (4, 5)):
            with self.subTest(interval=(low, high)):
                self.assertTrue(target.overlaps(Interval(low, high)))
