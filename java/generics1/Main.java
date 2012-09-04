package generics1;
import generics1.GenericNode;

public class Main {
    public static void main(String[] args) {
        GenericNode<String> myNode = new GenericNode<String>("I'm a generic node!");
        System.out.println(myNode.getNodeAsString());
    }
}
