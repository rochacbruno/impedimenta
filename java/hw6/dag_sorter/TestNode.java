package dag_sorter;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

/**
 * Unit tests for class <code>Node</code>.
 */
public class TestNode {
    /**
     * Ensures the constructor properly populates a Node object with
     * appropriate fields.
     */
    @Test
    public void TestConstructor() {
        Node node = new Node(15);

        assertEquals(15,     node.id);
        assertEquals(false,  node.visited);
        assertEquals(true,   node.neighbors.isEmpty());
        assertEquals(0,      node.neighbors.size());
    }

    /**
     * Tests equality of Node objects.
     */
    @Test
    public void TestEquality() {
        Node n1 = new Node(1);
        Node n2 = new Node(1);
        Node n3 = new Node(-1);

        assertEquals(true,   n1.equals(n1));
        assertEquals(true,   n1.equals(n2));
        assertEquals(false,  n1.equals(n3));

        assertEquals(true,   n2.equals(n1));
        assertEquals(true,   n2.equals(n2));
        assertEquals(false,  n2.equals(n3));

        assertEquals(false,  n3.equals(n1));
        assertEquals(false,  n3.equals(n2));
        assertEquals(true,   n3.equals(n3));

        assertEquals(false,  n1.equals("not a Node object"));
    }

    /**
     * Tests ordering of Node objects.
     */
    @Test
    public void TestOrdering() {
        Node n1 = new Node(-1);
        Node n2 = new Node(0);
        Node n3 = new Node(1);

        assertEquals(0,  n1.compare(n1, n1));
        assertEquals(-1, n1.compare(n1, n2));
        assertEquals(-1, n1.compare(n1, n3));

        assertEquals(1,  n1.compare(n2, n1));
        assertEquals(0,  n1.compare(n2, n2));
        assertEquals(-1, n1.compare(n2, n3));

        assertEquals(1,  n1.compare(n3, n1));
        assertEquals(1,  n1.compare(n3, n2));
        assertEquals(0,  n1.compare(n3, n3));
    }

    /**
     * Ensures that a Node cannot have duplicate Neighbors.
     */
    @Test
    public void TestDuplicateNeighbors() {
        Node n1 = new Node(0);

        // A node in a graph may have an edge pointing to itself.
        n1.neighbors.add(n1);
        assertEquals(1, n1.neighbors.size());

        // But a node in a graph cannot (?) have two edges pointing to itself.
        n1.neighbors.add(n1);
        assertEquals(1, n1.neighbors.size());

        // Nodes are equal if they have the same ID.
        n1.neighbors.add(new Node(0));
        assertEquals(1, n1.neighbors.size());

        // Nodes are not equal if they have a unique ID.
        n1.neighbors.add(new Node(1));
        assertEquals(2, n1.neighbors.size());
    }
}
