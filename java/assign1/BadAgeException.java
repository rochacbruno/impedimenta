package assign1;

/**
 * Exception thrown when a person's age is set to an impossible value.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class BadAgeException extends RuntimeException {
    public BadAgeException() {
        super("Cannot set age to specified value.");
    }

    public BadAgeException(String msg) {
        super(msg);
    }
}
