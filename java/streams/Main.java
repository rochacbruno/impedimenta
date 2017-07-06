import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/** Parse string arrays with streams. */
public class Main {
    public static void main(String[] args) {
        String[] paragraph = new String[]{
            "Nothing is certain",
            "But null pointer exception",
            "Guess why it occurred",
            "—John Smith"
        };

        System.out.println("Source string:");
        System.out.println();
        for (String sentence : paragraph) {
            System.out.println(sentence);
        }
        System.out.println();
        System.out.println(
            "Average number of words in each sentence: " +
            getAvgSentenceLength(paragraph));
        System.out.println("Words by length: " + getWordsByLength(paragraph));
        System.out.println(
            "Character frequencies: " + getCharFreqsByChar(paragraph));
    }

    /** Return the average length of each sentence in the given paragraph. */
    public static double getAvgSentenceLength(String[] paragraph) {
        return Stream
            .of(paragraph)
            .map(line -> line.split(" +"))
            .map(lineWords -> Array.getLength(lineWords))
            .collect(Collectors.averagingInt(numWords -> numWords));
    }

    /** Return a map of words, keyed by their length. */
    public static Map<Integer, List<String>> getWordsByLength(String[] paragraph) {
        return Stream
            .of(paragraph)
            .map(line -> line.split(" +"))
            .flatMap(lineWords -> Stream.of(lineWords))
            .collect(Collectors.groupingBy(
                word -> word.length(),
                Collectors.toList()
            ));
    }

    /** Return a character frequency chart. */
    public static Map<String, Long> getCharFreqsByChar(String[] paragraph) {
        // Remember: the function passed to flatMap() returns a stream for each
        // object it's called on. flatMap() concatenates those streams.
        return Stream
            .of(paragraph)
            .map(line -> line.split(""))
            .flatMap(lineLetters -> Stream.of(lineLetters))
            .collect(Collectors.groupingBy(
                letter -> letter,
                Collectors.counting()
            ));
    }
}
