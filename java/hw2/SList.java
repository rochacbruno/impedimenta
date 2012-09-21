package hw2;
import hw2.SListException;

/**
 * A generic implementation of a forward singly linked list.
 */
public class SList<T> {
    private Node<T> head;
    private int length;

    /** Constructor. Creates a singly linked list with no nodes. */
    public SList() {
        length = 0;
        head = null;
    }

    /** Returns the number of nodes in this <code>SList</code>. */
    public int size() {
        return length;
    }

    /** 
     * Returns a <code>String</code> representation of the nodes in this
     * <code>SList</code>.
     */
    public String toString() {
        if(0 == length) return "";
        Node<T> pointer = head;
        String listAsString = pointer.toString();

        // This is more reliable than ``for(int i = 0; i < length; i++)``. It's
        // possible that one of the other methods in this class could misbehave
        // and muck with length, and this method provides a sanity check.
        while(null != (pointer = pointer.getLink())) {
            listAsString += ", " + pointer.toString();
        }
        return listAsString;
    }

    /**
     * Prints a representation of the nodes in this list to
     * <code>System.out</code>. The string printed is identical to that returned
     * by <code>this.toString</code>.
     */
    public void print() {
        System.out.println(toString());
    }

    /**
     * Places info in the Nth node of this <code>SList</code>, where
     * <code>n</code> is a zero-based index. The head of the list is at index
     * position 0. Throws <code>SListException</code> if element <code>n</code>
     * does not exist.
     */
    public void insertNth(int n, T info) throws SListException {
        if(n > length)
            throw new SListException(
                "Cannot create list element: " + n + ". List has " + length +
                " elements. (indices 0 - " + (length - 1) + ")"
            );

        Node<T> newNode = new Node<T>(info);
        if(0 == n) {
            newNode.setLink(head);
            head = newNode;
        } else {
            Node<T> pointer = head;
            for(int i = 1; i < n; i++)
                pointer = pointer.getLink();
            newNode.setLink(pointer.getLink());
            pointer.setLink(newNode);
        }
        length++;
    }

    /**
     * Places <code>info</code> at the beginning of this <code>SList</code>.
     */
    public void insertFirst(T info) {
        insertNth(0, info);
    }

    /**
     * Places <code>info</code> at the end of this <code>SList</code>.
     */
    public void insertLast(T info) {
        insertNth(length, info);
    }

    /**
     * Returns info in the Nth node of this <code>SList</code>, where
     * <code>n</code> is a zero-based index. The head of the list is at index
     * position 0. Throws <code>SListException</code> if element <code>n</code>
     * does not exist.
     */
    public T getNth(int n) throws SListException {
        if(n >= length)
            throw new SListException(
                "Cannot access list element: " + n + ". List has " + length +
                " elements. (indices 0 - " + (length - 1) + ")"
            );

        Node<T> pointer = head;
        for(int i = 0; i < n; i++)
            pointer = pointer.getLink();
        return pointer.getInfo();
    }

    /**
     * Returns info in the first node of this <code>SList</code>. Throws
     * <code>SListException</code> if list is emtpy.
     */
    public T getFirst() {
        return getNth(0); 
    }

    /**
     * Returns info in the last node of this <code>SList</code>. Throws
     * <code>SListException</code> if list is emtpy.
     */
    public T getLast() {
        return getNth(length - 1);
    }

    /**
     * Removes the Nth node from this <code>SList</code>, where <code>n</code>
     * is a zero-based index. The head of the list is at index position 0.
     * Throws <code>SListException</code> if element <code>n</code> does not
     * exist.
     */
    public void removeNth(int n) throws SListException {
        if(n >= length) {
            throw new SListException(
                "Cannot remove list element: " + n + ". List has " + length +
                " elements. (indices 0 - " + (length - 1) + ")"
            );
        } else if(0 == n) {
            head = head.getLink();
        } else {
            Node<T> pointer = head;
            for(int i = 1; i < n; i++)
                pointer = pointer.getLink();
            pointer.setLink(pointer.getLink().getLink());
        }
        length--;
    }

    /**
     * Removes the first node from this <code>SList</code>. Throws
     * <code>SListException</code> if list is empty.
     */
    public void removeFirst() {
        removeNth(0);
    }

    /**
     * Removes the last node from this <code>SList</code>. Throws
     * <code>SListException</code> if list is empty.
     */
    public void removeLast() {
        removeNth(length - 1);
    }

    /** A simple class which can be used to construct singly linked lists. */
    private class Node<T> {
        private T info;
        private Node<T> next;

        /**
         * Constructor. New node will hold <code>info</code> and point to
         * <code>null</code>.
         */
        public Node(T info) {
            this.info = info;
            next = null;
        }

        /**
         * Constructor. New node will hold <code>info</code> and point to
         * <code>next</code>.
         */
        public Node(T info, Node<T> next) {
            this.info = info;
            this.next = next;
        }

        /** Returns a copy of the info that this node contains. */
        public T getInfo() {
            return info;
        }

        /** Makes this node point to <code>next</code>. */
        public void setLink(Node<T> next) {
            this.next = next;
        }

        /** Returns the node that this node points to. If this node does not
         * point to any other node, returns <code>null</code>.
         */
        public Node<T> getLink() {
            return next;
        }

        /** Returns a string representation of the info in this node. */
        public String toString() {
            return info.toString();
        }
    }
}
