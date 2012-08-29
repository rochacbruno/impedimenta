#!/bin/sh
exec scala "$0" "$@"
!#

/** Tells user if first command line argument is a prime number.
  *
  * Tells user if argument is not an integer or if argument is missing.
  */
object Main {
    /** Returns true if arg is a prime number. */
    def isPrime(num: Int): Boolean = {
        if(num <= 1) return false
        for(i <- 2 until num) {
            if(0 == num % i) {
                return false
            }
        }
        return true
    }

    /** The intended entry point for this program. */
    def main(args: Array[String]) = {
        val num = try {
            args(0).toInt
        } catch {
            case err: java.lang.NumberFormatException =>
                println("Argument is not an integer number.")
                println(err)
                sys.exit(1)
            case err: java.lang.ArrayIndexOutOfBoundsException =>
                println("No argument passed in.")
                println(err)
                sys.exit(1)
            case err =>
                println(
                    "Unknown excepion while converting " + args(0) + " to int."
                )
                println(err)
                sys.exit(1)
        }

        if(this.isPrime(num)) {
            println(num + " is a prime number.")
        } else {
            println(num + " is not a prime number.")
        }
    }
}
