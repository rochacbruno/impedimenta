package hw2;

/**
 * Exception thrown when something silly is done with an <code>SList</code>.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class SListException extends RuntimeException {
    public SListException(String msg) {
        super(msg);
    }
}
