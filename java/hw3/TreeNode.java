package hw3;
import java.lang.Comparable;

/**
 * A node which can be used to construct binary search trees.
 *
 * <code>&lt;T extends Comparable&lt;? super T&gt;&gt;</code> means:
 * "<code>T</code> is a type that is comparable to itself or to some superclass
 * of itself." See:
 * http://onjava.com/pub/a/onjava/excerpt/javaian5_chap04/index1.html
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class TreeNode<T extends Comparable<? super T>> {
    private T value;
    private TreeNode<T> left;
    private TreeNode<T> right;

    /**
     * Constructs a node containing <code>value</code>. The new node has no
     * children or parent.
     */
    public TreeNode(T value) {
        this.value = value;
        left = null;
        right = null;
    }

    /**
     * Returns <code>value</code> from this node.
     */
    public T getValue() {
        return value;
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
     *
     * This method will not function unless type <code>T</code> implements the
     * <code>Comparable</code> interface.
     */
    public void add(T value) {
        if(0 > value.compareTo(this.value)) {
            // new value less than this.value
            if(null == left) {
                left = new TreeNode<T>(value);
            } else {
                left.add(value);
            }
        } else if(0 < value.compareTo(this.value)) {
            // new value greater than this.value
            if(null == right) {
                right = new TreeNode<T>(value);
            } else {
                right.add(value);
            }
        }
        // else if (value == this.value)
            // do nothing, because value is already in tree
    }

    /**
     * Returns a string representing an in-order traversal of this node and it's
     * subtrees.
     */
    public String toString() {
        if(null == left && null == right) {
            return value.toString();
        } else if(null == left && null != right) {
            return value.toString() + ", " + right.toString();
        } else if(null != left && null == right) {
            return left.toString() + ", " + value.toString();
        } else {
            return left.toString() + ", " + value.toString() + ", " +
                right.toString();
        }
    }

    /**
     * Returns a string representing a pre-order traversal of this node and it's
     * subtrees.
     */
    public String toStringPre() {
        if(null == left && null == right) {
            return value.toString();
        } else if(null == left && null != right) {
            return value.toString() + ", " + right.toStringPre();
        } else if(null != left && null == right) {
            return value.toString() + ", " + left.toStringPre();
        } else {
            return value.toString() + ", " + left.toStringPre() + ", " +
                right.toStringPre();
        }
    }

    /**
     * Returns a string representing a post-order traversal of this node and
     * it's subtrees.
     */
    public String toStringPost() {
        if(null == left && null == right) {
            return value.toString();
        } else if(null == left && null != right) {
            return right.toStringPost() + ", " + value.toString();
        } else if(null != left && null == right) {
            return left.toStringPost() + ", " + value.toString();
        } else {
            return left.toStringPost() + ", " + right.toStringPost() + ", " +
                value.toString();
        }
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
