package sorts;

/**
 * A class that can sort an <code>int</code> array using the insertion sort
 * algorithm.
 */
public class InsertionSort extends Sort {
    /**
     * Constructor. Creates a randomly initizlied array with
     * Sort.DEFAULT_ARRAY_SIZE elements.
     */
    public InsertionSort() {
        super();
    }

    /**
     * Constructor. Creates an array that can be sorted.
     * @param numElements the number of elements in the array to be sorted
     */
    public InsertionSort(int numElements) {
        super(numElements);
    }

    /**
     * Constructor. Allows one to sort the array passed in.
     * @param array the array to sort
     */
    public InsertionSort(int[] array) {
        super(array);
    }

    /**
     * Perform the actual sort.
     */
    public void sort() {
        for(int i = 0; i < _array.length; i++) {
            for(int elem = i; elem > 0; elem--) {
                if(_array[elem - 1] > _array[elem]) {
                    // Swap _array[elem] and _array[elem - 1].
                    int temp = _array[elem - 1];
                    _array[elem - 1] = _array[elem];
                    _array[elem] = temp;
                } else {
                    // If _array[elem - 1] <= _array[elem], then
                    //    _array[elem - n] <= _array[elem].
                    break;
                }
            }
        }
    } // method sort()
} // class InsertionSort
