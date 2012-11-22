package sorts;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for class <code>MergeSort</code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class TestMergeSort {
    /**
     * Test the MergeSort constructors. Also tests <code>toString()</code>.
     */
    @Test
    public void TestConstructors() {
        // Ensure default constructor doesn't throw an exception.
        new MergeSort();

        MergeSort numbers = new MergeSort(5);
        assertTrue(5 == numbers.getArray().length);

        int[] numList = new int[]{1, 2, 3, 4, 5};
        numbers = new MergeSort(numList);
        assertTrue(5 == numbers.getArray().length);
        assertEquals("1, 2, 3, 4, 5", numbers.toString());
    }

    /**
     * Test the MergeSort sort algorithm. Also tests <code>toString()</code>
     * and <code>getArray()</code>.
     */
    /*
    @Test
    public void TestSort() {
        int[] numList = new int[]{2, 5, 1, 4, 3};
        MergeSort numbers = new MergeSort(numList);
        assertEquals("2, 5, 1, 4, 3", numbers.toString());
        numbers.sort();
        assertEquals("1, 2, 3, 4, 5", numbers.toString());

        numbers = new MergeSort(5);
        numbers.sort();
        numList = numbers.getArray();
        for(int i = 0; i < numList.length - 1; i++) {
            assertTrue(numList[i] <= numList[i + 1]);
        }

        numbers = new MergeSort();
        numbers.sort();
        numList = numbers.getArray();
        for(int i = 0; i < numList.length - 1; i++) {
            assertTrue(numList[i] <= numList[i + 1]);
        }
    }
    */
}
