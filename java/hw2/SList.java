package hw2;

/*
SList()  // default constructor. Creates an empty list
int size()   // return the size of the SList (number of elements in the list)
void insertFirst(T info)   // insert a Node with the specified info at the front of the SList
T getFirst()   // get the info part of the first element
void removeFirst()  // remove (delete) the first element in the SList
void insertNth(int n, const T data)   // insert element into the Nth position (zero based)
T getNth(int n)   // get the Nth element, where the list is zero based
void removeNth(int n)  // remove (delete) the Nth element in the SList
void insertLast(const T data)   // insert element into the last position
T getLast()   // get the last element
void removeLast()  // remove (delete) the last element in the SList
void print() // print the contents of the SList
*/

public class SList<T> {
    private Node<T> list;
    private int length;

    public SList() {
        length = 0;
        list = this.new Node<T>();
    }

    public int size() {
        return length;
    }

    private class Node<T> {
        private T info;
        private Node<T> next;

        public Node() {
            info = null;
            next = null;
        }

        // constructor
        public Node(T newInfo) {
            info = newInfo;
            next = null;
        }

        // constructor
        public Node(T newInfo, Node<T> newNext) {
            info = newInfo;
            next = newNext;
        }

        // return the T that this node contains
        public T getInfo() {
            return info;
        }

        // set the ``next`` pointer for this node
        public void setLink(Node<T> newNext) {
            next = newNext;
        }

        // get the ``next`` node
        public Node<T> getLink() {
            return next;
        }
    }
}
