package sorts;

public class InsertionSort extends Sort {
    /**
     * create a Sort, generating an array with a default 1000 elements
     */
    public InsertionSort() {
        super();
    }

    /**
     * create a Sort, generating an randome array with numElements elements
     * @param numElements the number of elements in the array to be sorted
     */
    public InsertionSort(int numElements) {
        super(numElements);
    }

    /**
     * create a Sort, which can be used to sort the passed in array
     * @param array the array to sort
     */
    public InsertionSort(int[] array) {
        super(array);
    }

    public void sort() {
    }
}
