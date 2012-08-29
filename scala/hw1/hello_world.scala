#!/bin/sh
exec scala "$0" "$@"
!#

/** A simple "Hello, world!" application. Demonstrates how scala thinks about
  * priority.
  */
object Main {
    println("Hello, world (inside the object, before the method)!")
    /** The intended entry point for this program. */
    def main(args: Array[String]) {
        println("Hello, World (inside the method)!")
    }
    println("Hello, world (inside the object, after the method)!")
}
// println("Hello, world (outside the object)!") // Try uncommenting this.
