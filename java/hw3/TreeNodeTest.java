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
        // do Integers work?
        TreeNode<Integer> nodeInt = new TreeNode<Integer>(42);
        assertTrue(42 == nodeInt.getValue());
        assertEquals("42", nodeInt.toString());
        // do Strings work?
        TreeNode<String> nodeString = new TreeNode<String>("Hullabaloo");
        assertEquals("Hullabaloo", nodeString.getValue());
        assertEquals("Hullabaloo", nodeString.toString());
    }

    /**
     * Ensure nodes can have children. Test the add(), left(), right(), and
     * getValue() methods.
     */
    @Test
    public void traverseManually() {
        // try adding nodes to the left side
        TreeNode<Integer> nodeInt = new TreeNode<Integer>(10);
        nodeInt.add(9);
        nodeInt.add(8);
        assertTrue(10 == nodeInt.getValue());
        assertTrue(9  == nodeInt.left().getValue());
        assertTrue(8  == nodeInt.left().left().getValue());

        // now try adding them to the right side
        nodeInt = new TreeNode<Integer>(10);
        nodeInt.add(11);
        nodeInt.add(12);
        assertTrue(10 == nodeInt.getValue());
        assertTrue(11 == nodeInt.right().getValue());
        assertTrue(12 == nodeInt.right().right().getValue());

        // create a fully populated, balanced tree with a height of 2
        nodeInt = new TreeNode<Integer>(10);
        nodeInt.add(0);
        nodeInt.add(-1);
        nodeInt.add(1);
        nodeInt.add(20);
        nodeInt.add(19);
        nodeInt.add(21);
        assertTrue(10 == nodeInt.getValue());
        assertTrue(0  == nodeInt.left().getValue());
        assertTrue(-1 == nodeInt.left().left().getValue());
        assertTrue(1  == nodeInt.left().right().getValue());
        assertTrue(20 == nodeInt.right().getValue());
        assertTrue(19 == nodeInt.right().left().getValue());
        assertTrue(21 == nodeInt.right().right().getValue());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        nodeInt = new TreeNode<Integer>(10);
        nodeInt.add(20);
        nodeInt.add(21);
        nodeInt.add(19);
        nodeInt.add(0);
        nodeInt.add(1);
        nodeInt.add(-1);
        assertTrue(10 == nodeInt.getValue());
        assertTrue(0  == nodeInt.left().getValue());
        assertTrue(-1 == nodeInt.left().left().getValue());
        assertTrue(1  == nodeInt.left().right().getValue());
        assertTrue(20 == nodeInt.right().getValue());
        assertTrue(19 == nodeInt.right().left().getValue());
        assertTrue(21 == nodeInt.right().right().getValue());

        // try adding children to the left side
        TreeNode<String>  nodeString = new TreeNode<String>("h");
        nodeString.add("g");
        nodeString.add("f");
        assertEquals("h", nodeString.getValue());
        assertEquals("g", nodeString.left().getValue());
        assertEquals("f", nodeString.left().left().getValue());

        // now try adding them to the right side
        nodeString = new TreeNode<String>("h");
        nodeString.add("i");
        nodeString.add("j");
        assertEquals("h", nodeString.getValue());
        assertEquals("i", nodeString.right().getValue());
        assertEquals("j", nodeString.right().right().getValue());

        // create fully populated, balanced tree with a height of 2
        nodeString = new TreeNode<String>("h");
        nodeString.add("b");
        nodeString.add("a");
        nodeString.add("c");
        nodeString.add("y");
        nodeString.add("x");
        nodeString.add("z");
        assertEquals("h", nodeString.getValue());
        assertEquals("b", nodeString.left().getValue());
        assertEquals("a", nodeString.left().left().getValue());
        assertEquals("c", nodeString.left().right().getValue());
        assertEquals("y", nodeString.right().getValue());
        assertEquals("x", nodeString.right().left().getValue());
        assertEquals("z", nodeString.right().right().getValue());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        nodeString = new TreeNode<String>("h");
        nodeString.add("y");
        nodeString.add("z");
        nodeString.add("x");
        nodeString.add("b");
        nodeString.add("c");
        nodeString.add("a");
        assertEquals("h", nodeString.getValue());
        assertEquals("b", nodeString.left().getValue());
        assertEquals("a", nodeString.left().left().getValue());
        assertEquals("c", nodeString.left().right().getValue());
        assertEquals("y", nodeString.right().getValue());
        assertEquals("x", nodeString.right().left().getValue());
        assertEquals("z", nodeString.right().right().getValue());
    }
}
