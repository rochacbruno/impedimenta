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
        _array = mergeSort(_array);
    }

    /**
     * Performs a merge sort. This function splits <code>array</code> into two
     * sub-arrays, (recursively) sorts them, then returns the merged sub-arrays.
     *
     * This implementation of merge sort is conceptually very simple, but also
     * space-inefficient. Each time <code>mergeSort</code> is called, new
     * sub-arrays <code>left</code> and <code>right</code> are created.
     */
    private int[] mergeSort(int[] array) {
        // Arrays of this size are, by definition, already sorted.
        if(1 >= array.length)
            return array;

        // Create and populate sub-arrays left and right.
        int midIndex = array.length / 2;
        int[] left  = new int[midIndex];
        int[] right = new int[array.length - midIndex];
        for(int i = 0; i < midIndex; i++) {
            left[i] = array[i];
        }
        for(int i = midIndex; i < array.length; i++) {
            right[i - midIndex] = array[i];
        }

        // Recursively sort the sub-arrays.
        left = mergeSort(left);
        right = mergeSort(right);

        // Then merge them back together.
        return merge(left, right);
    }

    /**
     * Merges <code>left</code> and <code>right</code> together in order, then
     * returns the ordered array.
     */
    private int[] merge(int[] left, int[] right) {
        int[] merged = new int[left.length + right.length];

        // merge left and right
        int l = 0; // left index
        int r = 0; // right index
        int m = 0; // merged index
        for(; m < merged.length; m++) {
            if(l >= left.length) {
                // The left list has already been "emptied".
                merged[m] = right[r++];
            } else if(r >= right.length) {
                // The right list has already been "emptied".
                merged[m] = left[l++];
            } else {
                // Neither left nor right have been "emptied". Figure out which
                // to take from.
                if(left[l] <= right[r]) {
                    merged[m] = left[l++];
                } else {
                    merged[m] = right[r++];
                }
            }
        }

        return merged;
    }
} // class MergeSort
