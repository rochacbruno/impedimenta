package hw3;
import hw3.TreeNode;

// Instructions: https://moodle.vsc.edu/file.php/7387/assign3.html

/**
 * A binary search tree.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class Tree<T> {
    private TreeNode<T> root;

    /**
     * constructs a Tree
     */
    public Tree() {
        root = null;
    }

    public Tree(T data) {
        root = new TreeNode<T>(data);
    }

    /**
     * returns the root node of the Tree.
     */
    public TreeNode<T> getRoot() {
        return root;
    }

    /**
     * adds value to the correct place within the tree
     */
    public void add(T value) {
    }

    /**
     * performs an in order print of the tree
     */
    public void print() {
    }

    /**
     * performs a preorder print of the tree
     */
    public void printPre() {
    }

    /**
     * performs a postorder print of the tree
     */
    public void printPost() {
    }

    /**
     * Returns true if <code>value</code> is found in the tree, false otherwise.
     */
    public boolean search(T value) {
        return false;
    }

    /**
     * Returns true if <code>value</code> is removed from the tree, false
     * otherwise.
     */
    public boolean delete(T value) {
        return false;
    }
}
