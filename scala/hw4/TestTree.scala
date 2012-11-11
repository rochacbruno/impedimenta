import hw4.Leaf
import hw4.Node
import hw4.OrderedProperties
import hw4.Tree
import org.scalatest.FunSuite

/**
 * Uses composition to give <code>Int</code>s the methods in <code>
 * OrderedProperties</code>.
 */
class IntHasOrderedProperties(val num: Int) extends OrderedProperties[Int] {
    override def minimum(): Int = Int.MinValue
    override def maximum(): Int = Int.MaxValue
    override def compare(that: Int): Int = {
        if     (num <  that) -1
        else if(num == that)  0
        else                  1
    }
    override def toString(): String = num.toString()
}

/** Companion object to <code>IntHasOrderedProperties</code>. */
object IntHasOrderedProperties {
    /**
     * Allows implicit conversions from <code>Int</code> to <code>
     * IntHasOrderedProperties</code>.
     */
    implicit def Int2IntHasOrderedProperties(num: Int): IntHasOrderedProperties =
        new IntHasOrderedProperties(num)

    /**
     * Allows implicit conversions from <code>IntHasOrderedProperties</code> to
     * <code>Int</code>.
     */
    implicit def IntHasOrderedProperties2Int(specialNum: IntHasOrderedProperties): Int =
        specialNum.num
}

/**
 * Unit tests for class <code>IntHasOrderedProperties</code> and module <code>
 * Tree</code>.
 */
class TestTree extends FunSuite {
    test("Implicitly convert from Int to IntHasOrderedProperties") {
        def printFn(num: IntHasOrderedProperties): String = num.toString()

        assert("-4" === printFn(-4))
        assert("0"  === printFn( 0))
        assert("85" === printFn(85))
    }

    test("Test identity of standalone IntHasOrderedProperties objects.") {
        val num = new IntHasOrderedProperties(-1)

        assert(-1   === num.num)
        assert("-1" === num.toString())
        assert(num  === num)
        assert(num  !=  new IntHasOrderedProperties(-1))
    }

    test("Check min & max of IntHasOrderedProperties objects.") {
        assert(Int.MinValue === new IntHasOrderedProperties(0).minimum())
        assert(Int.MaxValue === new IntHasOrderedProperties(0).maximum())
    }

    test("Order several IntHasOrderedProperties objects.") {
        val smaller = new IntHasOrderedProperties(4)
        val larger  = new IntHasOrderedProperties(5)

        assert(smaller <  larger)
        assert(smaller <= larger)
        assert(larger >  smaller)
        assert(larger >= smaller)
        assert(0 === smaller.compare(smaller))
        assert(0 === larger.compare(larger))
        assert(0 > smaller.compare(larger))
        assert(0 < larger.compare(smaller))
    }

    test("Create a single-element Tree[Int].") {
        val num = 10
        val tree = new Node[Int](Leaf, num, Leaf)

        assert(1 === Tree.size(tree))
        // assert(true  === Tree.lookup(tree, num)) // ERROR
        // assert(false === Tree.lookup(tree,  20)) // ERROR
        assert("Node(Leaf,10,Leaf)" === tree.toString())
        // assert(10 === Tree.min(tree)) // ERROR
        // assert(10 === Tree.max(tree)) // ERROR
    }
}
