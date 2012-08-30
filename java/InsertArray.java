import java.util.Arrays;

/**
 * Insert an element into an existing array. Purely demonstrative.
 */
public class InsertArray {
    /**
     * Returns copy of arr with insertMe inserted. Assumes arr is ordered.
     */
    private static Integer[] insertIntoArray(
        final Integer[] arr,
        final Integer insertMe
    ) {
        Integer[] newArr = new Integer[arr.length + 1];
        Integer   offset = 0;

        if(0 == arr.length) { // check for empty array
            newArr[0] = insertMe;
            return newArr;
        }
        for(int i = 0; i < arr.length; i++) {
            if(0 == offset && insertMe <= arr[i]) {
                newArr[i] = insertMe;
                offset++;
            }
            newArr[i + offset] = arr[i];
        }
        // 0 if insertMe never inserted
        if(0 == offset) newArr[newArr.length - 1] = insertMe;

        return newArr;
    }

    /**
     * Runs informal unit tests on insertIntoArray and prints out results.
     */
    public static void main(String[] args) {
        Integer val = 6;

        System.out.println("Inserting: " + val);
        System.out.println(Arrays.toString(insertIntoArray(
            new Integer[]{-1, 0, -1, 5},
            val
        )));
        System.out.println(Arrays.toString(insertIntoArray(
            new Integer[]{7, 8},
            val
        )));
        System.out.println(Arrays.toString(insertIntoArray(
            new Integer[]{5, 6, 7},
            val
        )));
        System.out.println(Arrays.toString(insertIntoArray(
            new Integer[0],
            val
        )));
    }
}
