/**
 * 4. (5 pts) Write a function compose that takes two functions and returns a
 * another function obtained by successively applying the given two functions to
 * a particular argument. For example suppose f is the function that adds one to
 * its argument and g is the function that doubles its argument. Then the
 * function returned by compose should double the result of adding one to its
 * argument. That is, the function returned by compose should return g(f(x)).
 * Specifically::
 *
 *     val f = (x : Int) =&gt; x + 1
 *     val g = (x : Int) =&gt; 2 * x
 *     val result = compose(f, g)
 *     val n = result(5)  // n is bound to 2 * (5 + 1) = 12
 *
 * Note that compose only needs to be able to compose functions taking a single
 * integer parameter and returning Int. Hint: Return a function literal.
 */
object Main {
    /**
     * Returns a function literal second(first()). The resultant function
     * literal can only take a single integer parameter.
     */
    def compose(first: (Int) => Int, second: (Int) => Int): (Int) => Int = {
        (x: Int) => second(first(x))
    }

    /**
     * Tests compose() by feeding it various functions and testing the resultant
     * function literals.
     */
    def main(args: Array[String]): Unit = {
        val num = 5
        val f = (x: Int) => x + 1
        val g = (x: Int) => x * 2

        //val composition = (x: Int) => g(f(x)) // This works!
        println("f(" + num + "): " + f(num))
        println("g(" + num + "): " + g(num))
        println("compose(f, g).apply(" + num + "): " + compose(f, g).apply(5))
        println("compose(g, f).apply(" + num + "): " + compose(g, f).apply(5))
    }
}
