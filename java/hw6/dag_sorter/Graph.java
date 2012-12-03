package dag_sorter;

import java.util.HashMap;
import java.util.Set;
import java.util.Iterator;

public class Graph {
    HashMap<Integer, Node> nodes;

    /**
     * Creates an empty graph.
     */
    public Graph() {
        nodes = new HashMap<Integer, Node>();
    }

    /**
     * Adds an edge to this graph. Creates <code>src</code> and <code>dest
     * </code> nodes to the graph if necessary.
     */
    public void addEdge(Integer src, Integer dest) {
        // Create graph vertices if they do not already exist.
        if(! nodes.containsKey(src)) {
            nodes.put(src, new Node(src));
        }
        if(! nodes.containsKey(dest)) {
            nodes.put(dest, new Node(dest));
        }

        nodes.get(src).outEdges.put(dest, nodes.get(dest));
        nodes.get(dest).inEdges.put(src, nodes.get(src));
    }

    /**
     * Returns the nodes in this graph, topologically sorted.
     */
    public Node[] sortNodes() { // TODO: implement this method
        Node[] orderedNodes = new Node[nodes.size()];
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
        Set<Integer> keys = nodes.keySet();
        for(Iterator<Integer> iter = keys.iterator(); iter.hasNext();) {
            Integer key = iter.next();
            repr += nodes.get(key).toString() + ", ";
        }
        repr = repr.split(", $")[0]; // strip trailing ", "
        return repr;
    }
}
