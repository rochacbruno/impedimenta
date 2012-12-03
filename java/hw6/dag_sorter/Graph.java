package dag_sorter;

import java.util.HashSet;

public class Graph {
    HashSet<Node> nodes;

    /**
     * Creates an empty graph.
     */
    public Graph() {
        nodes = new HashSet<Node>();
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
        repr = repr.split(", $")[0]; // strip trailing ", "
        return repr;
    }
}
