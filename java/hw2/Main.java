package hw2;
import hw2.Node;

/*
To be turned in:

Your implementation of the Node class. This class should be private within the SList class.
Your implementation of the SList class.  Both classes should be appropriately commented. Note -- this means you only turn in SList.java, since the Node class will be within.
A set of tests that fully tests the SList class. Be sure to test all the public methods.  Test with more than one type, to ensure that your generics are working properly. These tests should be junit tests. Please name this file <Yourname>Test.java
Within both SList and Node, include a comment specifying the runtime performance (Big-Oh notation) of each method.
*/

/**
 * The Main class exercises other classes in package hw2.
 */
public class Main {
    /**
     * Class Node provides the components of a linked list. This method
     * demonstrates, in a nutshell, how to create and "walk" down a linked list.
     * A LinkedList class has not been written.
     */
    public static void main(String[] args) {
        Node<String> myStringNode = new Node<String>("I'm the tail node.");
        Node<Integer> myIntNode = new Node<Integer>(42, myStringNode);
        Node<Object> head = new Node<Object>(null, myIntNode);

        System.out.println(
            "Head cannot be printed, because it's \"data\" member is null. "
            + "But the next two nodes in this linked list can.\n"
            + "head.data: null\n"
            + "head.next.data: " + head.next.data.toString() + "\n"
            + "head.next.next.data: " + head.next.next.data.toString()
        );
    }
}
