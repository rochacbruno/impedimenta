// Run junit tests from the command line with the following:
// javac -cp .:/usr/share/java/junit.jar assign1/UnorderedArrayListTest.java
// java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore assign1.UnorderedArrayListTest
package assign1;
import static org.junit.Assert.*;
import org.junit.Test;

/**
 * @author ldamon
 * @author Jeremy Audet <ichimonji10@gmail.com>
 */
public class UnorderedArrayListTest {
    /**
     * Create an UnorderedArrayList<Integer>. Add elements to end using
     * insertEnd(), and remove using remove().
     */
    @Test
    public void addTwoIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertEnd(1);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        // 2 elements
        list.insertEnd(2);
        assertTrue(2 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 1 2 ]", list.toString());

        // 1 element
        list.remove(2);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        // 0 elements
        list.remove(1);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create an UnorderedArrayList<Integer>. Add elements to end using
     * insertAt(), and remove using remove().
     */
    @Test
    public void addThreeIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();

        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        list.insertAt(0, 1);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        list.insertAt(1, 2);
        assertTrue(2 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 1 2 ]", list.toString());

        list.insertAt(2, 3);
        assertTrue(3 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 3));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 2));
        assertTrue(3 == list.get(2));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 1 2 3 ]", list.toString());

        list.remove(1);
        assertTrue(2 == list.size());
        assertTrue(2 == list.get(0));
        assertTrue(2 == list.get(list.size() - 2));
        assertTrue(3 == list.get(1));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 2 3 ]", list.toString());

        list.remove(2);
        assertTrue(1 == list.size());
        assertTrue(3 == list.get(0));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 3 ]", list.toString());

        list.remove(3);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    @Test 
    public void testEmptyList() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();

        assertTrue(false == emptyList.remove(1));
    }

    @Test (expected=IndexOutOfBoundsException.class)
    public void testEmptyListGet() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();

        emptyList.get(emptyList.size() - 1);
    }
}
