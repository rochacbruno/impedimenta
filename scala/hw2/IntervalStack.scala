package hw2
import collection.immutable.Stack

/** A simple implementation of a stack of Intervals.
 *
 * Note: an alternate solution is to create new Stack[Interval]() as needed.
 * Note: am not inheriting from Stack
 */
class IntervalStack {
    private var stack = new Stack[Interval]()

    /** Push a new Interval onto this stack. */
    def push(newTop: Interval): Unit = {
        stack = stack.push(newTop)
    }

    /** Returns the topmost Interval on this stack.
     *
     * If no elements on stack, throws IndexOutOfBoundsException.
     */
    @throws(classOf[IndexOutOfBoundsException])
    def pop(): Interval = {
        val retVal = stack(0)
        stack = stack.pop // throws
        retVal
    }
}
