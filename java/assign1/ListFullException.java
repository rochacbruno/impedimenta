package assign1;

/**
 * Exception thrown when a list is at its capacity
 *
 * @author ldamon
 */
public class ListFullException extends RuntimeException {
    private static final long serialVersionUID = 2247861726773273845L;

    public ListFullException() {
        super("List is full");
    }
}
