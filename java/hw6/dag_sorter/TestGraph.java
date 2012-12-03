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
        graph.addEdge(0, 1);

        // Two nodes should automatically be created with their inEdges and
        // outEdges set appropriately.
        assertEquals(2, graph.nodes.size());
        assertTrue("0, 1".equals(graph.toString()) || "1, 0".equals(graph.toString()));
        // Node 0 has no incoming edges and an outgoing edge to node 1.
        assertEquals(0, graph.nodes.get(0).inEdges.size());
        assertEquals(1, graph.nodes.get(0).outEdges.size());
        assertTrue(1 == graph.nodes.get(0).outEdges.get(1).id);
        // Node 1 has an incoming edge from node 0 and no outgoing edges.
        assertEquals(1, graph.nodes.get(1).inEdges.size());
        assertEquals(0, graph.nodes.get(1).outEdges.size());
        assertTrue(0 == graph.nodes.get(1).inEdges.get(0).id);

        graph.nodes.clear();
        graph.addEdge(0, 0);

        // One node should automatically be created with it's inEdges and
        // outEdges set appropriately.
        assertEquals(1, graph.nodes.size());
        assertEquals("0", graph.toString());
        // Node has an incoming edge from, and an outgoing edge to, node 0.
        assertEquals(1, graph.nodes.get(0).inEdges.size());
        assertEquals(1, graph.nodes.get(0).outEdges.size());
        assertTrue(0 == graph.nodes.get(0).inEdges.get(0).id);
        assertTrue(0 == graph.nodes.get(0).outEdges.get(0).id);
    }
}
