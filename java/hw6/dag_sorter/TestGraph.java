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

        graph.nodes.put(0, new Node(0));
        assertEquals("0", graph.toString());

        graph.nodes.put(1, new Node(1));
        assertTrue("0, 1".equals(graph.toString()) || "1, 0".equals(graph.toString()));
    }

    /**
     * Ensures the addEdge() method works correctly.
     */
    @Test
    public void TestAddEdge() {
        Graph graph = new Graph();

        // Nodes should automatically be created.
        graph.addEdge(0, 1);
        assertEquals(2, graph.nodes.size());
        assertTrue("0, 1".equals(graph.toString()) || "1, 0".equals(graph.toString()));
        // Node 0 should have one neighbor: node 1.
        // Node 1 should have no neighbors.
        assertEquals(1, graph.nodes.get(0).neighbors.size());
        assertEquals(0, graph.nodes.get(1).neighbors.size());

        graph.nodes.clear();

        // It should be possible for a node to have an edge pointing to itself.
        graph.addEdge(0, 0);
        assertEquals(1, graph.nodes.size());
        assertEquals("0", graph.toString());
        // Node 0 should have one nieghbor: node 0.
        assertEquals(1, graph.nodes.get(0).neighbors.size());
    }
}
