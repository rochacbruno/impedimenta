package generics1;
import generics1.GenericNode;

public class Main {
    public static void main(String[] args) {
        GenericNode<String> myStringNode = new GenericNode<String>("I'm a generic node!");
        GenericNode<Integer> myIntNode = new GenericNode<Integer>(42);

        System.out.println(myStringNode.data.toString());
        System.out.println(myIntNode.data.toString());
    }
}
