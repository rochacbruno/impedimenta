package sorts;

/**
 * An abstract class that is useful for testing out various sorting algorithms.
 * This class provides some niceties like randomly filling an array with values,
 * returning the array, and printing out the array. To use, create a subclass
 * with a sort() method that actually sorts the array of values.
 *
 * @author ldamon
 *
 */
public abstract class Sort {
    int[] _array;
    final static int DEFAULT_ARRAY_SIZE = 1000;

    /**
     * Constructor. Creates an array with <code>DEFAULT_ARRAY_SIZE</code>
     * elements and populates it with random values.
     */
    public Sort() {
        _array = generateArray(DEFAULT_ARRAY_SIZE);
    }

    /**
     * Constructor. Creates an array with <code>numElements</code> elements and
     * populates it with random values.
     * @param numElements The size of the array to be sorted.
     */
    public Sort(int numElements) {
        _array = generateArray(numElements);
    }

    /**
     * Constructor. Uses <code>array</code> as the array to be sorted.
     * @param array The array to be sorted.
     */
    public Sort(int[] array) {
        _array = array;
    }

    /**
     * Actually sorts the array.
     */
    public abstract void sort();

    /**
     * Creates an array of size <code>numElements</code> and populates it with
     * random integers between -1000 and 1000, inclusive.
     * @param numElements Size of the new array.
     * @return The newly created array.
     */
    private int[] generateArray(int numElements) {
        // Allocate our test array and fill it with random data.
        int[] arr = new int[numElements];
        for(int i = 0; i < numElements; ++i) {
            arr[i] = (int)(Math.random() * 1001); // 0 to 1000
            if(0 == (int)(Math.random() * 2)) { // 0 to 1
                arr[i] *= -1;
            }
        }
        return arr;
    }

    /**
     * Returns the array being sorted.
     */
    public int[] getArray() {
        return this._array;
    }

    /**
     * Returns a string representation of the array to be sorted. For example:
     * "2, 5, 1, 4, 3".
     */
    public String toString() {
        if(0 == _array.length) {
            return "";
        } else {
            String str = "" + _array[0];
            for(int i = 1; i < _array.length; i++) {
                str += ", " + _array[i];
            }
            return str;
        }
    }
}
