package hw1;

/**
 * Exception thrown when a person's age is set to an impossible value.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class PersonAgeException extends RuntimeException {
    public PersonAgeException(String msg) {
        super(msg);
    }
}
