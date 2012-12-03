package dag_sorter;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Reads in a text file whose contents describe an acyclic directed graph, and
 * prints out a topologically sorted version of that graph.
 *
 * If the file is not found, a descriptive error message is printed out and the
 * program exits. Each row describes one edge in a graph. Each row should
 * consist of two columns, like this:
 *
 *     1 2
 *     1 3
 *     2 4
 *     2 5
 *     3 5
 *     3 6
 *
 * In this case, there are six edges. The six edges are:
 *
 *     1 -&gt; 2
 *     1 -&gt; 3
 *     2 -&gt; 4
 *     2 -&gt; 5
 *     3 -&gt; 5
 *     3 -&gt; 6
 *
 */
public class SortFile {
    public static void main(String[] args) throws IOException {
        // Check arguments.
        if(args.length < 1) {
            System.out.println(
                "Usage: java dag_sorter.SortFile </path/to/file>"
            );
            return;
        }

        Graph graph = new Graph();

        // Read file and populate graph.
        try {
            BufferedReader handle = new BufferedReader(new FileReader(args[0]));
            Pattern p = Pattern.compile("^\\s*(\\d+)\\s+(\\d+)\\s*$");
            String line = null;

            while(null != (line = handle.readLine())) {
                Matcher m = p.matcher(line);
                if(! m.matches()) {
                    System.out.println("Discarding malformed line: " + line);
                    continue;
                }
                graph.addEdge(
                    Integer.decode(m.group(1)),
                    Integer.decode(m.group(2))
                );
            }

            handle.close();
        } catch(FileNotFoundException err) {
            System.out.println("File not found: " + args[0]);
        }

        // Print out graph, topologically sorted.
        Node[] sortedNodes = graph.sortNodes();
        if(0 == sortedNodes.length)
            System.out.println("No nodes in graph.");

        String repr = "";
        for(int i = 0; i < sortedNodes.length; i++) {
            repr += sortedNodes[i] + ", ";
        }
        repr = repr.split(", $")[0]; // strip trailing ", "
        System.out.println(repr);
    }
}
