package hw2;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for <code>SList</code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class JeremyAudetTest {
    /**
     * Create and test an SList&lt;Integer&gt;.
     */
    @Test
    public void addRemoveInteger() {
        SList<Integer> list = new SList<Integer>();
        assertTrue(0 == list.size());
    }
}
