package generics1;
import generics1.Node;

public class Main {
    public static void main(String[] args) {
        Node<String> myStringNode = new Node<String>("I'm the tail node.");
        Node<Integer> myIntNode = new Node<Integer>(42, myStringNode);
        Node<Object> head = new Node<Object>(null, myIntNode);

        System.out.println(head.next.data.toString());
        System.out.println(head.next.next.data.toString());
    }
}
