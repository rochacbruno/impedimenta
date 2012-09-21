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
     * Create an SList&lt;Integer&gt;. Exercise the insertFirst(), getFirst(),
     * and removeFirst() methods.
     */
    @Test
    public void insertGetRemoveFirstInteger() {
        // 0 elements
        SList<Integer> list = new SList<Integer>();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());
        // 1 element
        list.insertFirst(0);
        assertTrue(1 == list.size());
        assertTrue(0 == list.getFirst());
        assertEquals("0", list.toString());
        // 2 elements
        list.insertFirst(1);
        assertTrue(2 == list.size());
        assertTrue(1 == list.getFirst());
        assertEquals("1, 0", list.toString());
        // 1 element
        list.removeFirst();
        assertTrue(1 == list.size());
        assertTrue(0 == list.getFirst());
        assertEquals("0", list.toString());
        // 0 elements
        list.removeFirst();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());
    }

    /**
     * Create an SList&lt;Integer&gt;. Exercise the insertLast(), getLast(),
     * and removeLast() methods.
     */
    @Test
    public void insertGetRemoveLastInteger() {
        // 0 elements
        SList<Integer> list = new SList<Integer>();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());
        // 1 element
        list.insertLast(0);
        assertTrue(1 == list.size());
        assertTrue(0 == list.getLast());
        assertEquals("0", list.toString());
        // 2 elements
        list.insertLast(1);
        assertTrue(2 == list.size());
        assertTrue(1 == list.getLast());
        assertEquals("0, 1", list.toString());
        // 1 element
        list.removeLast();
        assertTrue(1 == list.size());
        assertTrue(0 == list.getLast());
        assertEquals("0", list.toString());
        // 0 elements
        list.removeLast();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());
    }

    /**
     * Create an SList&lt;Integer&gt;. Exercise the insertNth(), getNth(), and
     * removeNth() methods.
     */
    @Test
    public void insertGetRemoveNthInteger() {
        // 0 elements
        SList<Integer> list = new SList<Integer>();
        assertTrue(0 == list.size());
        assertEquals("", list.toString());
        // 1 element
        list.insertNth(0, 0); // (index, value)
        assertTrue(1 == list.size());
        assertTrue(0 == list.getNth(0));
        assertEquals("0", list.toString());
        // 2 elements
        list.insertNth(1, 1);
        assertTrue(2 == list.size());
        assertTrue(0 == list.getNth(0));
        assertTrue(1 == list.getNth(1));
        assertEquals("0, 1", list.toString());
        // 3 elements
        list.insertNth(1, 2);
        assertTrue(3 == list.size());
        assertTrue(0 == list.getNth(0));
        assertTrue(2 == list.getNth(1));
        assertTrue(1 == list.getNth(2));
        assertEquals("0, 2, 1", list.toString());
        // 2 elements
        list.removeNth(0);
        assertTrue(2 == list.getNth(0));
        assertTrue(1 == list.getNth(1));
        assertEquals("2, 1", list.toString());
        // 1 element
        list.removeNth(1);
        assertTrue(2 == list.getNth(0));
        assertEquals("2", list.toString());
        // 0 elements
        list.removeNth(0);
        assertEquals("", list.toString());
    }
}
