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
        assertEquals("42", treeInt.getRoot().toString());
        assertEquals("42", treeInt.toStringPre());
        assertEquals("42", treeInt.toString());
        assertEquals("42", treeInt.toStringPost());

        // Can I create one all in one go?
        treeInt = new Tree<Integer>(42);
        assertTrue(42 == treeInt.getRoot().getValue());
        assertEquals("42", treeInt.getRoot().toString());
        assertEquals("42", treeInt.toStringPre());
        assertEquals("42", treeInt.toString());
        assertEquals("42", treeInt.toStringPost());

        // Can I create a Tree<String>?
        Tree<String> treeString = new Tree<String>();
        assertTrue(null == treeString.getRoot());
        treeString.add("Hullabaloo");
        assertEquals("Hullabaloo", treeString.getRoot().getValue());
        assertEquals("Hullabaloo", treeString.getRoot().toString());
        assertEquals("Hullabaloo", treeString.toStringPre());
        assertEquals("Hullabaloo", treeString.toString());
        assertEquals("Hullabaloo", treeString.toStringPost());

        // Can I create one all in one go?
        treeString = new Tree<String>("Hullabaloo");
        assertEquals("Hullabaloo", treeString.getRoot().getValue());
        assertEquals("Hullabaloo", treeString.getRoot().toString());
        assertEquals("Hullabaloo", treeString.toStringPre());
        assertEquals("Hullabaloo", treeString.toString());
        assertEquals("Hullabaloo", treeString.toStringPost());
    }
}
