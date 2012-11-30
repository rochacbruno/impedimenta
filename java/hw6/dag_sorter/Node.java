package dag_sorter;

import java.util.Set;

// TODO: add methods necessary for this Node to be used in a Set
/**
 * Represents a node in a directed acyclic graph.
 */
public class Node {
    final int id;
    Set<Node> neighbors;
    boolean visited;

    /**
     * Creates a node with ID <code>id</code>, <code>visited = false</code>, and
     * no neighbors.
     */
    public Node(int id) {
        this.id = id;
        visited = false;
    }

    /**
     * A String representation of this node. Returns this node's ID as a String.
     */
    @Override
    public String toString() {
        return "" + id;
    }
}
