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
     * Create several different types of Nodes. Ensure the data stored in them
     * can be read back again.
     */
    @Test
    public void createReadNodes() {
        TreeNode<Integer> nodeInt = new TreeNode<Integer>(42);
        TreeNode<String> nodeString = new TreeNode<String>("Hullabaloo");
        assertTrue(42 == nodeInt.getValue());
        assertTrue("Hullabaloo" == nodeString.getValue());
    }
}
