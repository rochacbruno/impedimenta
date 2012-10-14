package hw3;

/**
 * A node which can be used to construct binary search trees.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class TreeNode<T> {
    private T data;
    private TreeNode<T> left;
    private TreeNode<T> right;

    /**
     * Constructs a node containing <code>data</code>. The new node has no
     * children or parent.
     */
    public TreeNode(T data) {
        this.data = data;
        left = null;
        right = null;
    }

    /**
     * Returns <code>data</code> from this node.
     */
    public T getValue() {
        return data;
    }

    /**
     * Makes <code>left</code> the left child of this node. If a sub-tree
     * already exists there, it will be lost.
     */
    public void setLeft(TreeNode<T> left) {
        this.left = left;
    }

    /**
     * Makes <code>right</code> the right child of this node. If a sub-tree
     * already exists there, it will be lost.
     */
    public void setRight(TreeNode<T> right) {
        this.right = right;
    }

    /**
     * Returns the left child node. If no node exists there, <code>null</code>
     * is returned.
     */
    public TreeNode<T> left() {
        return left;
    }

    /**
     * Returns the right child node. If no node exists there, <code>null</code>
     * is returned.
     */
    public TreeNode<T> right() {
        return right;
    }

    /**
     * Adds <code>value</code> to this node or one of it's subtrees.
     */
    public void add(T value) {
        // TODO
    }

    /**
     * Returns a string representing an in-order traversal of this node and it's
     * subtrees.
     */
    public String toString() {
        // TODO
        return "blargh";
    }

    /**
     * Returns a string representing a pre-order traversal of this node and it's
     * subtrees.
     */
    public String toStringPre() {
        // TODO
        return "blargh";
    }

    /**
     * Returns a string representing a post-order traversal of this node and
     * it's subtrees.
     */
    public String toStringPost() {
        // TODO
        return "blargh";
    }

    /**
     * Prints an in-order representation of this node and it's subtrees to
     * stdout.
     */
    public void print() {
        System.out.println(toString());
    }

    /**
     * Prints a pre-order representation of this node and it's subtrees to
     * stdout.
     */
    public void printPre() {
        System.out.println(toStringPre());
    }

    /**
     * Prints a post-order representation of this node and it's subtrees to
     * stdout.
     */
    public void printPost() {
        System.out.println(toStringPost());
    }
}
