package hw3;
import hw3.TreeNode;

// Instructions: https://moodle.vsc.edu/file.php/7387/assign3.html

/**
 * A binary search tree.
 *
 * All nodes in a tree must be of the same type. No automatic or explicit
 * balancing can be performed on the tree.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class Tree<T> {
    private TreeNode<T> root;

    /**
     * Creates an empty tree.
     */
    public Tree() {
        root = null;
    }

    /**
     * Creates a tree whose root contains <code>data</code>.
     */
    public Tree(T data) {
        root = new TreeNode<T>(data);
    }

    /**
     * Returns the root node of the tree. If the tree is empty,
     * <code>null</code> is returned.
     */
    public TreeNode<T> getRoot() {
        return root;
    }

    /**
     * Adds <code>value</code> to the tree.
     */
    public void add(T value) {
        root.add(value);
    }

    /**
     * Returns a string representing an in-order traversal of this tree.
     */
    public String toString() {
        return root.toString();
    }

    /**
     * Returns a string representing a pre-order traversal of this tree.
     */
    public String toStringPre() {
        return root.toStringPre();
    }

    /**
     * Returns a string representing a post-order traversal of this tree.
     */
    public String toStringPost() {
        return root.toStringPost();
    }

    /**
     * Prints an in-order representation of tree to stdout.
     */
    public void print() {
        System.out.println(toString());
    }

    /**
     * Prints a pre-order representation of tree to stdout.
     */
    public void printPre() {
        System.out.println(toStringPre());
    }

    /**
     * Prints a post-order representation of tree to stdout.
     */
    public void printPost() {
        System.out.println(toStringPost());
    }

    /**
     * Returns true if <code>value</code> is found in the tree. Otherwise,
     * returns false.
     */
    public boolean search(T value) {
        // TODO
        return false;
    }

    /**
     * Returns true if <code>value</code> is removed from the tree. Otherwise,
     * returns false.
     */
    public boolean delete(T value) {
        // TODO
        return false;
    }
}
