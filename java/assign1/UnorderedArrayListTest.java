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
     * Create an UnorderedArrayList<Integer>. Add elements to end, then remove
     * them from the end.
     */
    @Test
    public void addTwoIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertEnd(1);
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertTrue(1 == list.size());

        // 2 elements
        list.insertEnd(2);
        assertTrue(2 == list.size());
        assertTrue(1 == list.get(0));
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

    @Test
    public void addThreeIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();
        list.insertEnd(1);
        int result = list.get(0);
        assertTrue(result == 1);
        result = list.get(list.size()-1);
        assertTrue(result == 1);
        int size = list.size();
        assertTrue(size == 1);

        list.insertEnd(2);
        result = list.get(0);
        assertTrue(result == 1);
        result = list.get(list.size()-1);
        assertTrue(result == 2);
        size = list.size();
        assertTrue("expected 2, received "+size,size == 2);
        System.out.println("Printing list: expect list with two elements '1  2'");
        System.out.println(list);

        list.insertEnd(3);
        result = list.get(0);
        assertTrue(result == 1);
        result = list.get(list.size()-1);
        assertTrue(result == 3);
        size = list.size();
        assertTrue("expected 3, received "+size,size == 3);
        System.out.println("Printing list: expect list with two elements '1  2  3'");
        System.out.println(list);

        list.remove(1);
        size = list.size();
        assertTrue(size == 2);
        result = list.get(0);
        assertTrue(result == 2);
        result = list.get(list.size()-1);
        assertTrue(result == 3);

        System.out.println("Printing list: expect list with 2 element '2  3'");
        System.out.println(list);

        list.remove(2);
        size = list.size();
        assertTrue(size == 1);
        result = list.get(0);
        assertTrue("expected 3, received "+result, result == 3);
        result = list.get(list.size()-1);
        assertTrue(result == 3);

        System.out.println("Printing list: expect list with 1 element '3'");
        System.out.println(list);

        list.remove(3);
        size = list.size();
        assertTrue(size == 0);

        System.out.println("Printing list: expect list with 0 elements");
        System.out.println(list);
    }

    @Test 
    public void testEmptyList() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();
        boolean result = emptyList.remove(1);
        assertTrue(result == false);
    }

    @Test (expected=IndexOutOfBoundsException.class)
    public void testEmptyListGet() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();
        emptyList.get(emptyList.size()-1);
    }
}
