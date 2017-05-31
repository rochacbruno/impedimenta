/**
 * A simple demonstration of how to call a varargs method.
 */
public class Varargs {
    public static void main(String[] args) {
        System.out.println(accumulate(1, 2, 3));
        System.out.println(accumulate(new Integer[]{1, 2, 3}));
    }

    /**
     * Return the sum of the given integers.
     */
    private static Integer accumulate(Integer... numbers) {
        Integer total = new Integer(0);
        for (Integer i: numbers) {
            total += i;
        }
        return total;
    }
}
