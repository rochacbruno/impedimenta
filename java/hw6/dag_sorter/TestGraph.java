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
        graph.addEdge(0, 0);
        assertEquals(1, graph.nodes.size());
        // Node has an incoming edge from, and an outgoing edge to, node 0.
        assertEquals(1, graph.nodes.get(0).inEdges.size());
        assertEquals(1, graph.nodes.get(0).outEdges.size());
        assertTrue(0 == graph.nodes.get(0).inEdges.get(0).id);
        assertTrue(0 == graph.nodes.get(0).outEdges.get(0).id);

        graph.nodes.clear();
        graph.addEdge(0, 1);
        assertEquals(2, graph.nodes.size());
        // Node 0 has no incoming edges and an outgoing edge to node 1.
        assertEquals(0, graph.nodes.get(0).inEdges.size());
        assertEquals(1, graph.nodes.get(0).outEdges.size());
        assertTrue(1 == graph.nodes.get(0).outEdges.get(1).id);
        // Node 1 has an incoming edge from node 0 and no outgoing edges.
        assertEquals(1, graph.nodes.get(1).inEdges.size());
        assertEquals(0, graph.nodes.get(1).outEdges.size());
        assertTrue(0 == graph.nodes.get(1).inEdges.get(0).id);
    }

    /**
     * Ensures that sortNodes works correctly.
     */
    @Test
    public void TestSortNodes() {
        // An empty graph should yield a zero-length list of nodes.
        Graph graph = new Graph();
        assertEquals(0, graph.sortNodes().length);

        // Test a graph consisting of (0 -> 1).
        graph.addEdge(0, 1);
        Node[] sortedNodes = graph.sortNodes();
        assertEquals(2, sortedNodes.length);
        assertTrue(0 == sortedNodes[0].id);
        assertTrue(1 == sortedNodes[1].id);

        // Test a graph consisting of (0 -> 1 -> 2).
        graph.addEdge(1, 2);
        sortedNodes = graph.sortNodes();
        //
        assertEquals(3, sortedNodes.length);
        assertTrue(0 == sortedNodes[0].id);
        assertTrue(1 == sortedNodes[1].id);
        assertTrue(2 == sortedNodes[2].id);

        // Test a graph consisting of (0, 1 -> 2 -> 3).
        graph.nodes.clear();
        graph.addEdge(0, 2);
        graph.addEdge(1, 2);
        graph.addEdge(2, 3);
        sortedNodes = graph.sortNodes();
        //
        assertEquals(4, sortedNodes.length);
        assertTrue(0 == sortedNodes[0].id || 1 == sortedNodes[0].id);
        assertTrue(0 == sortedNodes[1].id || 1 == sortedNodes[1].id);
        assertTrue(sortedNodes[0].id != sortedNodes[1].id);
        assertTrue(2 == sortedNodes[2].id);
        assertTrue(3 == sortedNodes[3].id);

        // Test a graph consisting of (0 -> 1 -> 2, 3).
        graph.nodes.clear();
        graph.addEdge(0, 1);
        graph.addEdge(1, 2);
        graph.addEdge(1, 3);
        sortedNodes = graph.sortNodes();
        //
        assertEquals(4, sortedNodes.length);
        assertTrue(0 == sortedNodes[0].id);
        assertTrue(1 == sortedNodes[1].id);
        assertTrue(2 == sortedNodes[2].id || 3 == sortedNodes[2].id);
        assertTrue(2 == sortedNodes[3].id || 3 == sortedNodes[3].id);
        assertTrue(sortedNodes[2].id != sortedNodes[3].id);
    }
}
