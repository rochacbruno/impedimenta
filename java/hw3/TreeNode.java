package hw3;

/**
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class TreeNode<T> {
    private T data;
    private TreeNode<T> left;
    private TreeNode<T> right;

    /**
     * constructs a Node
     */
    public TreeNode(T data) {
        this.data = data;
        left = null;
        right = null;
    }

    /**
     * gets the value from the Node
     */
    public T getValue() {
        return data;
    }

    /**
     * sets the left child
     */
    public void setLeft(TreeNode<T> left) {
        this.left = left;
    }

    /**
     * sets the right child
     */
    public void setRight(TreeNode<T> right) {
        this.right = right;
    }

    /**
     * returns the node on the left
     */
    public TreeNode<T> left() {
        return left;
    }

    /**
     * returns the node on the right
     */
    public TreeNode<T> right() {
        return right;
    }

    /**
     * adds value to the correct place within the tree
     */
    public void add(T value) {
    }

    /**
     * performs an in order print of the node
     */
    public void print() {
    }
}
