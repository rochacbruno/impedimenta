import hw4.Tree
import hw4.Node
import hw4.Leaf

/**
 * Wraps Int to give it the Ordered trait.
 */
class OrderedInt(newNum: Int) extends Ordered[OrderedInt] {
    val num: Int = newNum

    override def compare(that: OrderedInt): Int = {
        if     (num <  that.num) -1
        else if(num == that.num)  0
        else                      1
    }

    override def toString(): String = {
        num.toString()
    }
}

/**
 * Tests the ability to compare OrderedInt instances, both by themselves and in
 * a Tree.
 */
object Main {
    def main(args: Array[String]) = {
        val smaller: OrderedInt = new OrderedInt(4)
        val larger:  OrderedInt = new OrderedInt(6)
        println("smaller < larger? " + (smaller < larger)) // true
        println("smaller == larger? " + (smaller == larger)) // false
        println("smaller > larger? " + (smaller > larger)) // false
        println("larger == larger? " + (larger == larger)) // true

        var tree: Node[OrderedInt] = new Node[OrderedInt](Leaf, larger, Leaf)
        println("size of newly created tree: " + Tree.size(tree))
        println("tree contents: " + tree)
        println("new OrderedInt(5) in tree? " + Tree.lookup(tree, new OrderedInt(5)))
        println("new OrderedInt(6) in tree? " + Tree.lookup(tree, new OrderedInt(6)))
        println(smaller + " in tree? " + Tree.lookup(tree, smaller))
        println(larger + " in tree? " + Tree.lookup(tree, larger))
    }
}
