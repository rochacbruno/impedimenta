import collection.immutable.Stack

// TODO: add docstrings

class IntervalStack {
    private var stack = new Stack[Interval]()

    def push(newTop: Interval): Unit = {
        stack = stack.push(newTop)
    }

    def pop(): Interval = {
        return stack.pop(0)
    }
}
