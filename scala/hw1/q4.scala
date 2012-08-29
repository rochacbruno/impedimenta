#!/bin/sh
exec scala "$0" "$@"
!#

/** Prints out a capitalized copy of all strings passed in. */
object Main {
    /** Makes the array of strings passed in uppercase. */
    def upperCase(words: Array[String]): Unit = {
        for(i <- 0 until words.length) {
            words(i) = words(i).toUpperCase()
        }
    }

    /** The intended entry point for this program. */
    def main(args: Array[String]) = {
        this.upperCase(args)
        args.foreach(arg => println(arg))
    }
}

/* The following approach to the homework problem requires less boilerplate
 * code. By my standards, it's a better solution. It works, too! But scaladoc
 * complains.
 */

/** Makes the array of strings passed in uppercase. */
/*
def upperCase(words: Array[String]): Unit = {
    for(i <- 0 to words.length - 1) {
        words(i) = words(i).toUpperCase()
    }
}

upperCase(args)
args.foreach(println)
*/
