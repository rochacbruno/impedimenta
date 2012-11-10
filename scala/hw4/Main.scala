import hw4.Tree
import hw4.Node
import hw4.Leaf

/**
 * Classes that implement <code>OrderedProperties[A]</code> must implement
 * <code>minimum </code>, <code>maximum</code>, and <code>compare</code>.
 */
abstract class OrderedProperties[A] extends Ordered[A] {
    def minimum(): A
    def maximum(): A
}

/**
 * Wraps <code>Int</code> to give it the methods in <code>OrderedProperties
 * </code>.
 */
class IntHasOrderedProperties(newNum: Int) extends OrderedProperties[IntHasOrderedProperties] {
    val num: Int = newNum

    // TODO: return *actual* min and max of scala.Int
    override def minimum(): IntHasOrderedProperties = new IntHasOrderedProperties(-100)
    override def maximum(): IntHasOrderedProperties = new IntHasOrderedProperties( 100)
    override def compare(that: IntHasOrderedProperties): Int = {
        if     (num <  that.num) -1
        else if(num == that.num)  0
        else                      1
    }
    override def toString(): String = num.toString()
}

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
        println("testOrderedInt()")
        println("================")
        testOrderedInt()
        println("")
        println("testIntHasOrderedProperties()")
        println("=============================")
        testIntHasOrderedProperties()
    }

    def testOrderedInt() = {
        val smaller: OrderedInt = new OrderedInt(4)
        val larger:  OrderedInt = new OrderedInt(6)
        println("smaller < larger? " + (smaller < larger)) // true
        println("smaller == larger? " + (smaller == larger)) // false
        println("smaller > larger? " + (smaller > larger)) // false
        println("larger == larger? " + (larger == larger)) // true

        val tree: Node[OrderedInt] = new Node[OrderedInt](Leaf, larger, Leaf)
        println("size of newly created tree: " + Tree.size(tree))
        println("tree contents: " + tree)
        println("new OrderedInt(5) in tree? " + Tree.lookup(tree, new OrderedInt(5)))
        println("new OrderedInt(6) in tree? " + Tree.lookup(tree, new OrderedInt(6)))
        println(smaller + " in tree? " + Tree.lookup(tree, smaller))
        println(larger + " in tree? " + Tree.lookup(tree, larger))
    }

    def testIntHasOrderedProperties() = {
        val smaller: IntHasOrderedProperties = new IntHasOrderedProperties(4)
        val larger:  IntHasOrderedProperties = new IntHasOrderedProperties(6)
        println("smaller < larger? " + (smaller < larger)) // true
        println("smaller == larger? " + (smaller == larger)) // false
        println("smaller > larger? " + (smaller > larger)) // false
        println("larger == larger? " + (larger == larger)) // true

        val tree: Node[IntHasOrderedProperties] = new Node[IntHasOrderedProperties](Leaf, larger, Leaf)
        println("size of newly created tree: " + Tree.size(tree))
        println("tree contents: " + tree)
        println("new IntHasOrderedProperties(5) in tree? " + Tree.lookup(tree, new IntHasOrderedProperties(5)))
        println("new IntHasOrderedProperties(6) in tree? " + Tree.lookup(tree, new IntHasOrderedProperties(6)))
        println(smaller + " in tree? " + Tree.lookup(tree, smaller))
        println(larger + " in tree? " + Tree.lookup(tree, larger))
    }
}
