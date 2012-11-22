package sorts;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for class <code>InsertionSort</code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class TestInsertionSort {
    /**
     * Test the InsertionSort constructors. Also tests <code>toString()</code>.
     */
    @Test
    public void TestConstructors() {
        // Ensure default constructor doesn't throw an exception.
        new InsertionSort();

        InsertionSort numbers = new InsertionSort(5);
        assertTrue(5 == numbers.getArray().length);

        int[] numList = new int[]{1, 2, 3, 4, 5};
        numbers = new InsertionSort(numList);
        assertTrue(5 == numbers.getArray().length);
        assertEquals("1, 2, 3, 4, 5", numbers.toString());
    }

    /**
     * Test the InsertionSort sort algorithm. Also tests <code>toString()</code>
     * and <code>getArray()</code>.
     */
    @Test
    public void TestSort() {
        int[] numList = new int[]{2, 5, 1, 4, 3};
        InsertionSort numbers = new InsertionSort(numList);
        assertEquals("2, 5, 1, 4, 3", numbers.toString());
        numbers.sort();
        assertEquals("1, 2, 3, 4, 5", numbers.toString());

        numbers = new InsertionSort(5);
        numbers.sort();
        numList = numbers.getArray();
        for(int i = 0; i < numList.length - 1; i++) {
            assertTrue(numList[i] <= numList[i + 1]);
        }

        numbers = new InsertionSort();
        numbers.sort();
        numList = numbers.getArray();
        for(int i = 0; i < numList.length - 1; i++) {
            assertTrue(numList[i] <= numList[i + 1]);
        }
    }
}
