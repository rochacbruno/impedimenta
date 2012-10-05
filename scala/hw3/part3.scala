/**
 * 3. (5 pts) Write a function toBinary that takes a list of n integers in the
 * range [0 .. 255] inclusive (8 bit integers) and returns a single 8*n bit
 * string of 0 and 1 digits that corresponds to the binary representation of the
 * bytes in the list. For example toBinary( List(128, 1) ) should evaluate to
 * "1000000000000001." Notice that only one string is returned.
 *
 * Hint: Use the toBinaryStringFunctional method in the BinaryString.scala
 * sample file to convert the individual numbers. Think about using map, maybe
 * twice (you'll have to pad short strings on the left with "0" characters), and
 * then foldLeft to combine the individual strings.
 */
object Main {
    // A functional method for converting an integer to a binary string.
    // Provided by Peter Chapin
    def toBinaryStringFunctional(n: Int): String = {
        if (n == 0) ""
        else {
            val binaryDigit = if (n % 2 == 0) "0" else "1"
            toBinaryStringFunctional(n / 2) + binaryDigit
        }
    }

    def toBinary(nums: List[Int]): String = {
        var result = ""
        for(num <- nums) {
            // TODO: create a custom exception
            if(255 < num)
                throw new Exception("toBinary: cannot represent numbers greater than 255")
            if(0 > num)
                throw new Exception("toBinary: cannot represent numbers less than 0")

            result += "0" * (8 - toBinaryStringFunctional(num).length) + toBinaryStringFunctional(num)
        }
        result
    }

    /**
     * Tests ``toBinary()`` with a variety of inputs. Prints the results of
     * these exercises to stdout.
     */
    def main(args: Array[String]): Unit = {
        val lists = List(
            List(),
            List(0),
            List(1),
            List(2),
            List(128),
            List(255),
            List(15, 13)
        )

        for(list <- lists) {
            println("input: " + list)
            println("output: " + toBinary(list))
            println()
        }

/*
        val boom = List(-1) // try -1 or 256
        println("input: " + boom)
        println("output: " + toBinary(boom))
*/
    }
}
