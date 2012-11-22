package sorts;

/**
 * A class that can sort an <code>int</code> array using the merge sort
 * algorithm.
 */
public class MergeSort extends Sort {
    /**
     * Constructor. Creates a randomly initizlied array with
     * Sort.DEFAULT_ARRAY_SIZE elements.
     */
    public MergeSort() {
        super();
    }

    /**
     * Constructor. Creates an array that can be sorted.
     * @param numElements the number of elements in the array to be sorted
     */
    public MergeSort(int numElements) {
        super(numElements);
    }

    /**
     * Constructor. Allows one to sort the array passed in.
     * @param array the array to sort
     */
    public MergeSort(int[] array) {
        super(array);
    }

    /**
     * Perform the actual sort.
     */
    public void sort() {
    } // method sort()
} // class MergeSort
