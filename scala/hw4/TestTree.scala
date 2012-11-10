import hw4.Leaf
import hw4.Node
import hw4.OrderedProperties
import hw4.Tree
import org.scalatest.FunSuite

/**
 * Uses composition to give <code>Int</code>s the methods in <code>
 * OrderedProperties</code>.
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
 * Unit tests for class <code>IntHasOrderedProperties</code> and module <code>
 * Tree</code>.
 */
class TestTree extends FunSuite {
    test("ensure IntHasOrderedProperties objects play nicely with each other") {
        val smaller: IntHasOrderedProperties = new IntHasOrderedProperties(4)
        val larger:  IntHasOrderedProperties = new IntHasOrderedProperties(6)

        assert("4" === smaller.toString())
        assert("6" === larger.toString())
        assert(smaller < larger)
        assert(smaller === smaller)
        assert(larger === larger)
        assert(false === smaller > larger)
    }

    test("create a one-node tree and identify the data in that node") {
        val smaller = new IntHasOrderedProperties(-5)
        val larger = new IntHasOrderedProperties(2)
        val tree = new Node[IntHasOrderedProperties](Leaf, smaller, Leaf)

        assert(1 === Tree.size(tree))
        assert(true === Tree.lookup(tree, smaller))
        assert(false === Tree.lookup(tree, larger))
        assert(false === Tree.lookup(tree, new IntHasOrderedProperties(-5)))
        assert(false === Tree.lookup(tree, new IntHasOrderedProperties( 2)))
        assert(false === Tree.lookup(tree, new IntHasOrderedProperties( 3)))
        assert("Node(Leaf,-5,Leaf)" === tree.toString())
    }
}
