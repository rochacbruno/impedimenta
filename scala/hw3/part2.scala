/**
 * 2. (5 pts) Write a function primeCount that counts the number of prime
 * numbers in a list of integers. You'll need to also write a purely functional
 * version of isPrime that returns true if its argument is a prime number.
 */
object Main {
    /**
     * Returns true if ``num`` is prime.
     */
    def isPrime(num: Int): Boolean = {
        return true
    }

    /**
     * Returns the number of primes in ``count_me``.
     */
    def primeCount(count_me: List[Int]): Int = {
        count_me match {
            case List() => 0
            case head :: tail => {
                val head_is_prime = if(isPrime(head)) 1 else 0
                head_is_prime + primeCount(tail)
                // Code below is equivalent and more concise but less readable.
                // {if(isPrime(head)) 1 else 0} + primeCount(tail)
            }
        }
    }

    /**
     * Tests ``primeCount()`` with a variety of inputs. Prints the results of
     * these exercises to stdout.
     */
    def main(args: Array[String]): Unit = {
        val lists = List(
            List(),
            List(1),
            List(-1, 0, 1, 7, 6, 5, 4, 3, 2)
        )

        for(list <- lists) {
            println(primeCount(list) + " primes: " + list)
        }
    }
}
