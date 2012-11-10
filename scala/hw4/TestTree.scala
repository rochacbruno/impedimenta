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

    override def minimum(): IntHasOrderedProperties = new IntHasOrderedProperties(Int.MinValue)
    override def maximum(): IntHasOrderedProperties = new IntHasOrderedProperties(Int.MaxValue)
    override def compare(that: IntHasOrderedProperties): Int = {
        if     (num <  that.num) -1
        else if(num == that.num)  0
        else                      1
    }
    override def toString(): String = num.toString()
}

/** Companion object to <code>IntHasOrderedProperties</code>. */
object IntHasOrderedProperties {
    /**
     * Allows implicit conversions from <code>Int</code> to <code>
     * IntHasOrderedProperties</code>.
     */
    implicit def Int2IntHasOrderedProperties(num: Int): IntHasOrderedProperties = {
        new IntHasOrderedProperties(num)
    }
}

/**
 * Unit tests for class <code>IntHasOrderedProperties</code> and module <code>
 * Tree</code>.
 */
class TestTree extends FunSuite {
    test("Test identity of standalone IntHasOrderedProperties objects.") {
        val num1: IntHasOrderedProperties = new IntHasOrderedProperties(-1)
        val num2: IntHasOrderedProperties = new IntHasOrderedProperties( 0)
        val num3: IntHasOrderedProperties = new IntHasOrderedProperties( 1)

        assert("-1" === num1.toString())
        assert(num1 === num1)
        assert(num1 != new IntHasOrderedProperties(-1))

        assert("0" === num2.toString())
        assert(num2 === num2)
        assert(num2 != new IntHasOrderedProperties(0))

        assert("1" === num3.toString())
        assert(num3 === num3)
        assert(num3 != new IntHasOrderedProperties(1))
    }

    test("Order several IntHasOrderedProperties objects.") {
        val smaller: IntHasOrderedProperties = new IntHasOrderedProperties(4)
        val larger:  IntHasOrderedProperties = new IntHasOrderedProperties(6)
        assert(smaller <  larger)
        assert(smaller <= larger)
        assert(false === smaller >  larger)
        assert(false === smaller >= larger)

        val larger2: IntHasOrderedProperties = new IntHasOrderedProperties(6)
        assert(larger <= larger2)
        assert(larger >= larger2)
    }

    test("Check min & max of IntHasOrderedProperties objects.") {
        assert(Int.MinValue.toString() === new IntHasOrderedProperties(0).minimum().toString())
        assert(Int.MaxValue.toString() === new IntHasOrderedProperties(0).maximum().toString())
    }

    test("Create and read a one-node tree.") {
        val num = new IntHasOrderedProperties(10)
        val tree = new Node[IntHasOrderedProperties](Leaf, num, Leaf)

        assert(1 === Tree.size(tree))
        assert(true  === Tree.lookup(tree, num))
        assert(false === Tree.lookup(tree, new IntHasOrderedProperties(10)))
        assert(false === Tree.lookup(tree, new IntHasOrderedProperties(20)))
        assert("Node(Leaf,10,Leaf)" === tree.toString())
    }

    test("Implicitly convert from Int to IntHasOrderedProperties") {
        def printFn(num: IntHasOrderedProperties): String = num.toString()
        assert("-4" === printFn(-4))
        assert("0"  === printFn( 0))
        assert("85" === printFn(85))
    }
}
