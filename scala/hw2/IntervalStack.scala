package edu.vtc.cis3030.hw2
import collection.immutable.Stack
// TODO: verify code here
// TODO: add docstrings

object IntervalStack {
    private var s = new Stack[Interval]()

    def push(value: Interval) = {
        s = s.push(value)
    }

    def pop() = {
        val value = s(0)
            s = s.pop
            value
    }
}
