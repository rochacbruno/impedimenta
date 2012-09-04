package generics1;

/**
 * A singly-linked node which can store any arbitrary data type.
 */
public class GenericNode<T> {
    public T data;
    public GenericNode next;

    /**
     * Constructor. Sets <code>data</code> to <code>initData</code> and
     * <code>next</code> to <code>null</code>.
     */
    public GenericNode(T initData) {
        data = initData;
        next = null;
    }

    /**
     * Constructor. Sets <code>data</code> to <code>initData</code> and
     * <code>next</code> to <code>initNext</code>.
     */
    public GenericNode(T initData, GenericNode initNext) {
        data = initData;
        next = initNext;
    }
}
