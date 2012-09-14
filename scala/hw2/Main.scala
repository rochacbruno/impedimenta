#!/bin/sh
exec scala "$0" "$@"
!#

object Main {
    def main(args: Array[String]) = {
        var line = ""
        while({ print("> "); line = readLine(); line != "" }) {
            val anInterval = Interval(line)
            println(anInterval)
        }
    }
}
