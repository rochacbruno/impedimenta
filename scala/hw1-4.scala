#!/bin/sh
exec scala "$0" "$@"
!#

object Main {
    def upperCase(words: Array[String]): Unit = {
        for(i <- 0 to words.length - 1) {
            words(i) = words(i).toUpperCase()
        }
    }

    def main(args: Array[String]) = {
        this.upperCase(args)
        args.foreach(println)
    }
}
