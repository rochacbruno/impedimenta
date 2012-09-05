package generics1;
import generics1.Node;

/**
 * The Main class exercises other classes in package generics1.
 */
public class Main {
    /**
     * Class Node provides the foundation for a linked list. A LinkedList class
     * has not yet been written, but this method demonstrates, in a nutshell,
     * how to "walk" down a linked list.
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
