#!/bin/sh
exec scala "$0" "$@"
!#

object Main {
    def main(args: Array[String]) = {
        val intervalStack = new IntervalStack()
        var line: String = ""

        while({ print("> "); line = readLine(); line != "" }) {
            val anInterval = Interval(line)
            println(anInterval)
        }
    }
}
