package sorts;

/**
 * Benchmarks the performance of <code>MergeSort</code> and <code>InsertionSort
 * </code>.
 *
 * @author Jeremy Audet &gt;ichmonji10@gmail.com&lt;
 */
public class BenchmarkSorts {
    public static int ARRAY_LENGTH = 40000;
    public static int RUNS = 30;

    public static void main(String[] args) {
        long[] timings;
        long avg;

        System.out.println("Array lengths: " + ARRAY_LENGTH);
        System.out.println("Runs for each algorithm: " + RUNS);

        System.out.println("");
        System.out.println("benchmarking merge sort");
        System.out.println("=======================");
        timings = BenchmarkMergeSort();
        avg = 0;
        for(int run = 0; run < timings.length; run++) {
            System.out.println(timings[run] + " ms");
            avg += timings[run];
        }
        avg /= timings.length;
        System.out.println("average runtime: " + avg + " ms");

        System.out.println("");
        System.out.println("benchmarking insertion sort");
        System.out.println("===========================");
        timings = BenchmarkInsertionSort();
        avg = 0;
        for(int run = 0; run < timings.length; run++) {
            System.out.println(timings[run] + " ms");
            avg += timings[run];
        }
        avg /= timings.length;
        System.out.println("average runtime: " + avg + " ms");
    }

    /**
     * Benchmarks the MergeSort algorithm.
     * @return An array containing the runtimes of each sort, in milliseconds.
     */
    public static long[] BenchmarkMergeSort() {
        long[] timings = new long[RUNS];
        Timer stopwatch = new Timer();

        for(int run = 0; run < RUNS; run++) {
            MergeSort nums = new MergeSort(ARRAY_LENGTH);
            stopwatch.reset();
            stopwatch.start();
            nums.sort();
            stopwatch.stop();
            timings[run] = stopwatch.time();
        }

        return timings;
    }

    /**
     * Benchmarks the InsertionSort algorithm.
     * @return An array containing the runtimes of each sort, in milliseconds.
     */
    public static long[] BenchmarkInsertionSort() {
        long[] timings = new long[RUNS];
        Timer stopwatch = new Timer();

        for(int run = 0; run < RUNS; run++) {
            InsertionSort nums = new InsertionSort(ARRAY_LENGTH);
            stopwatch.reset();
            stopwatch.start();
            nums.sort();
            stopwatch.stop();
            timings[run] = stopwatch.time();
        }

        return timings;
    }
}
