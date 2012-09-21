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
        // 0 elements
        SList<Integer> list = new SList<Integer>();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());

        // 1 element
        list.insertFirst(0);
        assertTrue(1 == list.size());
        assertTrue(0 == list.getFirst());
        assertTrue(0 == list.getLast());
        assertTrue(0 == list.getNth(0));
        assertEquals("0", list.toString());

        // 2 elements
        // TODO: exercise more ways of inserting at beginning, end, and Nth
        list.insertFirst(1);
        assertTrue(2 == list.size());
        assertTrue(1 == list.getFirst());
        assertTrue(0 == list.getLast());
        assertTrue(1 == list.getNth(0));
        assertTrue(0 == list.getNth(1));
        assertEquals("1, 0", list.toString());

        // 1 element
        list.removeFirst();
        assertTrue(1 == list.size());
        assertTrue(0 == list.getFirst());
        assertTrue(0 == list.getLast());
        assertTrue(0 == list.getNth(0));
        assertEquals("0", list.toString());
    }
}
