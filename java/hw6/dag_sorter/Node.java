package dag_sorter;

import java.util.HashMap;
import java.util.Comparator;

/**
 * Represents a node in a directed acyclic graph. A <code>Node</code> may have a
 * set of incoming and outgoing edges. Two nodes are equal if their <code>id
 * </code>s are equal.
 */
public class Node implements Comparator<Node> {
    final Integer id;
    HashMap<Integer, Node> inEdges;
    HashMap<Integer, Node> outEdges;
    boolean visited;

    /**
     * Creates a node with ID <code>id</code>, <code>visited = false</code>, and
     * no edges.
     */
    public Node(Integer id) {
        this.id = id;
        visited = false;
        inEdges = new HashMap<Integer, Node>();
        outEdges = new HashMap<Integer, Node>();
    }

    /**
     * A String representation of this node. Returns this node's ID as a String.
     */
    @Override
    public String toString() {
        return "" + id;
    }

    /**
     * Indicates the ordering of two Node objects. Compares the two objects
     * based on their id.
     * @return -1, 0, or 1 if <code>obj1</code> is less than, equal to, or
     * greater than <code>obj2</code>, respectively.
     */
    @Override
    public int compare(Node node1, Node node2) {
        if(node1.id < node2.id) {
            return -1;
        } else if(node1.id > node2.id) {
            return 1;
        } else {
            return 0;
        }
    }

    /**
     * Returns <code>true</code> if this <code>Node</code> object is equal to
     * <code>obj</code>, else <code>false</code>.
     */
    @Override
    public boolean equals(Object obj) {
        if(!(obj instanceof Node)) {
            return false;
        }
        Node node = (Node) obj;
        return id == node.id;
    }

    @Override
    public int hashCode() {
        return id;
    }
}
