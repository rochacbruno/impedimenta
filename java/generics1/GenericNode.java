package generics1;

public class GenericNode<T> {
    private T node;

    public GenericNode(T initT) {
        node = initT;
    }

    public String getNodeAsString() {
        return node.toString();
    }
}
