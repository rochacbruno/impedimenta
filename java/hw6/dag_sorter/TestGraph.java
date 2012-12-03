package dag_sorter;

import org.junit.Test;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

/**
 * Unit tests for class <code>Graph</code>.
 */
public class TestGraph {
    /**
     * Ensures the constructor properly populates a Graph object with
     * appropriate fields.
     */
    @Test
    public void TestConstructor() {
        Graph graph = new Graph();
        assertEquals(0, graph.nodes.size());
    }

    /**
     * Ensures the toString() method works correctly.
     */
    @Test
    public void TestToString() {
        Graph graph = new Graph();
        assertEquals("", graph.toString());

        graph.nodes.add(new Node(0));
        assertEquals("0", graph.toString());

        graph.nodes.add(new Node(1));
        assertTrue("0, 1".equals(graph.toString()) || "1, 0".equals(graph.toString()));
    }
}
