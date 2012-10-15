package hw3;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for <code>TreeNode</code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class TreeTest {
    /**
     * Ensure a single-element tree can be created and read from. Test both Tree
     * constructors, add(), getRoot(), and the toString methods.
     */
    @Test
    public void singleTree() {
        // Can I create a Tree<Integer>?
        Tree<Integer> treeInt = new Tree<Integer>();
        assertTrue(null == treeInt.getRoot());
        treeInt.add(42);
        assertTrue(42 == treeInt.getRoot().getValue());
        assertEquals("42", treeInt.toStringPre());
        assertEquals("42", treeInt.toString());
        assertEquals("42", treeInt.toStringPost());

        // Can I create one all in one go?
        treeInt = new Tree<Integer>(42);
        assertTrue(42 == treeInt.getRoot().getValue());
        assertEquals("42", treeInt.toStringPre());
        assertEquals("42", treeInt.toString());
        assertEquals("42", treeInt.toStringPost());

        // Can I create a Tree<String>?
        Tree<String> treeString = new Tree<String>();
        assertTrue(null == treeString.getRoot());
        treeString.add("Hullabaloo");
        assertEquals("Hullabaloo", treeString.getRoot().getValue());
        assertEquals("Hullabaloo", treeString.toStringPre());
        assertEquals("Hullabaloo", treeString.toString());
        assertEquals("Hullabaloo", treeString.toStringPost());

        // Can I create one all in one go?
        treeString = new Tree<String>("Hullabaloo");
        assertEquals("Hullabaloo", treeString.getRoot().getValue());
        assertEquals("Hullabaloo", treeString.toStringPre());
        assertEquals("Hullabaloo", treeString.toString());
        assertEquals("Hullabaloo", treeString.toStringPost());
    }

    /**
     * Create multi-element <code>Tree&lt;Integer&gt;</code>. Test the add(),
     * various toString(), getRoot(), and search() methods.
     */
    @Test
    public void multiTreeInteger() {
        // try adding nodes to the left side
        Tree<Integer> tree = new Tree<Integer>(10);
        tree.add(9);
        tree.add(8);
        assertTrue(10 == tree.getRoot().getValue());
        assertTrue(!tree.search(11));
        assertTrue( tree.search(10));
        assertTrue( tree.search(9));
        assertTrue( tree.search(8));
        assertTrue(!tree.search(7));
        assertEquals("10, 9, 8", tree.toStringPre());
        assertEquals("8, 9, 10", tree.toString());
        assertEquals("8, 9, 10", tree.toStringPost());

        // try adding nodes to the right side
        tree = new Tree<Integer>(10);
        tree.add(11);
        tree.add(12);
        assertTrue(10 == tree.getRoot().getValue());
        assertTrue(!tree.search(9));
        assertTrue( tree.search(10));
        assertTrue( tree.search(11));
        assertTrue( tree.search(12));
        assertTrue(!tree.search(13));
        assertEquals("10, 11, 12", tree.toStringPre());
        assertEquals("10, 11, 12", tree.toString());
        assertEquals("12, 11, 10", tree.toStringPost());

        // create a fully populated, balanced tree with a height of 2
        tree = new Tree<Integer>(10);
        tree.add(0);
        tree.add(-1);
        tree.add(1);
        tree.add(20);
        tree.add(19);
        tree.add(21);
        assertTrue(10 == tree.getRoot().getValue());
        assertTrue(!tree.search(-2));
        assertTrue( tree.search(-1));
        assertTrue( tree.search(0));
        assertTrue( tree.search(1));
        assertTrue(!tree.search(2));
        assertTrue(!tree.search(9));
        assertTrue( tree.search(10));
        assertTrue(!tree.search(11));
        assertTrue(!tree.search(18));
        assertTrue( tree.search(19));
        assertTrue( tree.search(20));
        assertTrue( tree.search(21));
        assertTrue(!tree.search(22));
        assertEquals("10, 0, -1, 1, 20, 19, 21", tree.toStringPre());
        assertEquals("-1, 0, 1, 10, 19, 20, 21", tree.toString());
        assertEquals("-1, 1, 0, 19, 21, 20, 10", tree.toStringPost());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        tree = new Tree<Integer>(10);
        tree.add(20);
        tree.add(21);
        tree.add(19);
        tree.add(0);
        tree.add(1);
        tree.add(-1);
        assertTrue(10 == tree.getRoot().getValue());
        assertTrue(!tree.search(-2));
        assertTrue( tree.search(-1));
        assertTrue( tree.search(0));
        assertTrue( tree.search(1));
        assertTrue(!tree.search(2));
        assertTrue(!tree.search(9));
        assertTrue( tree.search(10));
        assertTrue(!tree.search(11));
        assertTrue(!tree.search(18));
        assertTrue( tree.search(19));
        assertTrue( tree.search(20));
        assertTrue( tree.search(21));
        assertTrue(!tree.search(22));
        assertEquals("10, 0, -1, 1, 20, 19, 21", tree.toStringPre());
        assertEquals("-1, 0, 1, 10, 19, 20, 21", tree.toString());
        assertEquals("-1, 1, 0, 19, 21, 20, 10", tree.toStringPost());
    }

    /**
     * Create multi-element <code>Tree&lt;String&gt;</code>. Test the add(),
     * various toString(), getRoot(), and search() methods.
     */
    @Test
    public void multiTreeString() {
        // try adding children to the left side
        Tree<String> tree = new Tree<String>("h");
        tree.add("g");
        tree.add("f");
        assertTrue("h" == tree.getRoot().getValue());
        assertTrue(!tree.search("e"));
        assertTrue( tree.search("f"));
        assertTrue( tree.search("g"));
        assertTrue( tree.search("h"));
        assertEquals("h, g, f", tree.toStringPre());
        assertEquals("f, g, h", tree.toString());
        assertEquals("f, g, h", tree.toStringPost());

        // now try adding them to the right side
        tree = new Tree<String>("h");
        tree.add("i");
        tree.add("j");
        assertTrue("h" == tree.getRoot().getValue());
        assertTrue(!tree.search("g"));
        assertTrue( tree.search("h"));
        assertTrue( tree.search("i"));
        assertTrue( tree.search("j"));
        assertEquals("h, i, j", tree.toStringPre());
        assertEquals("h, i, j", tree.toString());
        assertEquals("j, i, h", tree.toStringPost());

        // create fully populated, balanced tree with a height of 2
        tree = new Tree<String>("h");
        tree.add("b");
        tree.add("a");
        tree.add("c");
        tree.add("y");
        tree.add("x");
        tree.add("z");
        assertTrue("h" == tree.getRoot().getValue());
        assertTrue(!tree.search("blergh"));
        assertTrue( tree.search("a"));
        assertTrue( tree.search("b"));
        assertTrue( tree.search("c"));
        assertTrue( tree.search("h"));
        assertTrue( tree.search("x"));
        assertTrue( tree.search("y"));
        assertTrue( tree.search("z"));
        assertEquals("h, b, a, c, y, x, z", tree.toStringPre());
        assertEquals("a, b, c, h, x, y, z", tree.toString());
        assertEquals("a, c, b, x, z, y, h", tree.toStringPost());

        // create another fully populated, balanced tree with a height of 2
        // create the children in a different order
        tree = new Tree<String>("h");
        tree.add("y");
        tree.add("z");
        tree.add("x");
        tree.add("b");
        tree.add("c");
        tree.add("a");
        assertTrue("h" == tree.getRoot().getValue());
        assertTrue(!tree.search("blergh"));
        assertTrue( tree.search("a"));
        assertTrue( tree.search("b"));
        assertTrue( tree.search("c"));
        assertTrue( tree.search("h"));
        assertTrue( tree.search("x"));
        assertTrue( tree.search("y"));
        assertTrue( tree.search("z"));
        assertEquals("h, b, a, c, y, x, z", tree.toStringPre());
        assertEquals("a, b, c, h, x, y, z", tree.toString());
        assertEquals("a, c, b, x, z, y, h", tree.toStringPost());
    }
}
