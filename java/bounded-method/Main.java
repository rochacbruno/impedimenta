/**
 * Invoke a method with a bounded type parameter.
 *
 * This code is derived from:
 * http://docs.oracle.com/javase/tutorial/java/generics/bounded.html
 */
public class Main {
    public static void main(String[] args) {
        Box<String> stringBox = new Box<String>();
        stringBox.set(new String("foo"));
        System.out.println(stringBox.get());
        System.out.println(stringBox.inspect(100));
        // System.out.println(stringBox.inspect(bar)); // compilation error
    }
}
