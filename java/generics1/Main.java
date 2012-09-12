package generics1;
import generics1.Node;

/**
 * The Main class exercises other classes in package generics1.
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
