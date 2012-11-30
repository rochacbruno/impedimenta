package dag_sorter;

import java.util.Set;

public class Graph {
    Set<Node> nodes;

    /**
     * Creates an empty graph.
     */
    public Graph() {};

    /**
     * Adds a new ndoe to this graph.
     */
    public void addNode(Node node) {
        nodes.add(node);
    }

    // TODO: implement topological sort
    /**
     * Returns the nodes in this graph, topologically sorted.
     */
    public Node[] sortNodes() {
        return new Node[]{new Node(0)};
    }

    /**
     * A String representation of this graph. Returns the IDs of each <code>Node
     * </code> in this <code>Graph</code>.
     */
    @Override
    public String toString() {
        if(0 == nodes.size()) {
            return "";
        }

        String repr = "";
        for(java.util.Iterator<Node> iter = nodes.iterator(); iter.hasNext();) {
            Node node = iter.next();
            repr += node.toString() + ", ";
        }
        return repr;
    }
}
