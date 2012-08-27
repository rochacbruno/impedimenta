#!/bin/sh
exec scala "$0" "$@"
!#

object Main {
    def upperCase(words: Array[String]): Unit = {
        for(i <- List.range(0, words.length)) {
            words(i) = words(i).toUpperCase()
        }
    }

    def main(args: Array[String]) = {
        this.upperCase(args)
        args.foreach(println)
    }
}
