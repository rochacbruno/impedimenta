package hw3;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for <code>TreeNode</code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class TreeNodeTest {
    /**
     * Ensure standalone nodes can be created and read from. Test the getValue()
     * and toString() methods.
     */
    @Test
    public void singleNodes() {
        // Can I create a TreeNode<Integer>?
        TreeNode<Integer> nodeInt = new TreeNode<Integer>(42);
        assertTrue(42 == nodeInt.getValue());
        assertEquals("42", nodeInt.toString());

        // Can I create a TreeNode<String>?
        TreeNode<String> nodeString = new TreeNode<String>("Hullabaloo");
        assertEquals("Hullabaloo", nodeString.getValue());
        assertEquals("Hullabaloo", nodeString.toString());
    }

    /**
     * Ensure that nodes, by default, have children of <code>null</code>.
     */
    @Test
    public void nullChildren() {
        // Nodes should have null children whether they're TreeNode<Integer>...
        TreeNode<Integer> nodeInt = new TreeNode<Integer>(-10);
        assertTrue(-10 == nodeInt.getValue());
        assertEquals("-10", nodeInt.toString());
        assertTrue(null == nodeInt.left());
        assertTrue(null == nodeInt.right());

        // ... or TreeNode<String>
        TreeNode<String> nodeString = new TreeNode<String>("say cheese");
        assertEquals("say cheese", nodeString.getValue());
        assertEquals("say cheese", nodeString.toString());
        assertTrue(null == nodeString.left());
        assertTrue(null == nodeString.right());
    }

    /**
     * Create a <code>TreeNode&lt;Integer&gt;</code> and add children to it.
     * Test the add(), left(), right(), getValue(), and various toString()
     * methods.
     */
    @Test
    public void createReadInteger() {
        // try adding nodes to the left side
        TreeNode<Integer> node = new TreeNode<Integer>(10);
        node.add(9);
        node.add(8);
        assertTrue(10 == node.getValue());
        assertTrue(9  == node.left().getValue());
        assertTrue(8  == node.left().left().getValue());
        assertEquals("10, 9, 8", node.toStringPre());
        assertEquals("8, 9, 10", node.toString());
        assertEquals("8, 9, 10", node.toStringPost());

        // now try adding them to the right side
        node = new TreeNode<Integer>(10);
        node.add(11);
        node.add(12);
        assertTrue(10 == node.getValue());
        assertTrue(11 == node.right().getValue());
        assertTrue(12 == node.right().right().getValue());
        assertEquals("10, 11, 12", node.toStringPre());
        assertEquals("10, 11, 12", node.toString());
        assertEquals("12, 11, 10", node.toStringPost());

        // create a fully populated, balanced tree with a height of 2
        node = new TreeNode<Integer>(10);
        node.add(0);
        node.add(-1);
        node.add(1);
        node.add(20);
        node.add(19);
        node.add(21);
        assertTrue(10 == node.getValue());
        assertTrue(0  == node.left().getValue());
        assertTrue(-1 == node.left().left().getValue());
        assertTrue(1  == node.left().right().getValue());
        assertTrue(20 == node.right().getValue());
        assertTrue(19 == node.right().left().getValue());
        assertTrue(21 == node.right().right().getValue());
        assertEquals("10, 0, -1, 1, 20, 19, 21", node.toStringPre());
        assertEquals("-1, 0, 1, 10, 19, 20, 21", node.toString());
        assertEquals("-1, 1, 0, 19, 21, 20, 10", node.toStringPost());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        node = new TreeNode<Integer>(10);
        node.add(20);
        node.add(21);
        node.add(19);
        node.add(0);
        node.add(1);
        node.add(-1);
        assertTrue(10 == node.getValue());
        assertTrue(0  == node.left().getValue());
        assertTrue(-1 == node.left().left().getValue());
        assertTrue(1  == node.left().right().getValue());
        assertTrue(20 == node.right().getValue());
        assertTrue(19 == node.right().left().getValue());
        assertTrue(21 == node.right().right().getValue());
        assertEquals("10, 0, -1, 1, 20, 19, 21", node.toStringPre());
        assertEquals("-1, 0, 1, 10, 19, 20, 21", node.toString());
        assertEquals("-1, 1, 0, 19, 21, 20, 10", node.toStringPost());
    }

    /**
     * Create a <code>TreeNode&lt;String&gt;</code> and add children to it.
     * Test the add(), left(), right(), getValue(), and various toString()
     * methods.
     */
    @Test
    public void createReadString() {
        // try adding children to the left side
        TreeNode<String> node = new TreeNode<String>("h");
        node.add("g");
        node.add("f");
        assertEquals("h", node.getValue());
        assertEquals("g", node.left().getValue());
        assertEquals("f", node.left().left().getValue());
        assertEquals("h, g, f", node.toStringPre());
        assertEquals("f, g, h", node.toString());
        assertEquals("f, g, h", node.toStringPost());

        // now try adding them to the right side
        node = new TreeNode<String>("h");
        node.add("i");
        node.add("j");
        assertEquals("h", node.getValue());
        assertEquals("i", node.right().getValue());
        assertEquals("j", node.right().right().getValue());
        assertEquals("h, i, j", node.toStringPre());
        assertEquals("h, i, j", node.toString());
        assertEquals("j, i, h", node.toStringPost());

        // create fully populated, balanced tree with a height of 2
        node = new TreeNode<String>("h");
        node.add("b");
        node.add("a");
        node.add("c");
        node.add("y");
        node.add("x");
        node.add("z");
        assertEquals("h", node.getValue());
        assertEquals("b", node.left().getValue());
        assertEquals("a", node.left().left().getValue());
        assertEquals("c", node.left().right().getValue());
        assertEquals("y", node.right().getValue());
        assertEquals("x", node.right().left().getValue());
        assertEquals("z", node.right().right().getValue());
        assertEquals("h, b, a, c, y, x, z", node.toStringPre());
        assertEquals("a, b, c, h, x, y, z", node.toString());
        assertEquals("a, c, b, x, z, y, h", node.toStringPost());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        node = new TreeNode<String>("h");
        node.add("y");
        node.add("z");
        node.add("x");
        node.add("b");
        node.add("c");
        node.add("a");
        assertEquals("h", node.getValue());
        assertEquals("b", node.left().getValue());
        assertEquals("a", node.left().left().getValue());
        assertEquals("c", node.left().right().getValue());
        assertEquals("y", node.right().getValue());
        assertEquals("x", node.right().left().getValue());
        assertEquals("z", node.right().right().getValue());
        assertEquals("h, b, a, c, y, x, z", node.toStringPre());
        assertEquals("a, b, c, h, x, y, z", node.toString());
        assertEquals("a, c, b, x, z, y, h", node.toStringPost());
    }

    /**
     * Ensure the setLeft() and setRight() methods work.
     */
    @Test
    public void setLeftRight() {
        TreeNode<Integer> left = new TreeNode<Integer>(9);
        TreeNode<Integer> parent = new TreeNode<Integer>(10);
        TreeNode<Integer> right = new TreeNode<Integer>(11);

        parent.setLeft(left);
        parent.setRight(right);
        assertTrue(10 == parent.getValue());
        assertTrue(9  == parent.left().getValue());
        assertTrue(11 == parent.right().getValue());
        assertEquals("10, 9, 11", parent.toStringPre());
        assertEquals("9, 10, 11", parent.toString());
        assertEquals("9, 11, 10", parent.toStringPost());
    }
}
