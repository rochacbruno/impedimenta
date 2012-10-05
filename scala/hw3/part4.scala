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
    def main(args: Array[String]): Unit = {
        println("Hello, world!")
    }
}
