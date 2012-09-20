package hw2;

// TODO: merge into SList.java
/*
Node should be a private class totally within the SList class.
Node (T info)
T getInfo()
void setLink (Node<T> next)   // set the link to the next node in our list
Node<T> getLink()     // retrieve the next element linked into our list
*/

/**
 * A singly-linked node which can store any arbitrary data type.
 */
public class Node<T> {
    public T data;
    public Node next;

    /**
     * Default constructor. Sets <code>data</code> and <code>next</code> to
     * null.
     */
    public Node() {
        data = null;
        next = null;
    }

    /**
     * Constructor. Sets <code>data</code> to <code>initData</code> and
     * <code>next</code> to <code>null</code>.
     */
    public Node(T initData) {
        data = initData;
        next = null;
    }

    /**
     * Constructor. Sets <code>data</code> to <code>initData</code> and
     * <code>next</code> to <code>initNext</code>.
     */
    public Node(T initData, Node initNext) {
        data = initData;
        next = initNext;
    }
}
