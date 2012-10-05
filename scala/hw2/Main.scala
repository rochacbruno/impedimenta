import hw2.Interval
import hw2.IntervalStack

/**
 * An implementation of a simple Interval calculator.
 *
 * Sample run:
 * &gt; [1.2, 4.5]  # Input an interval.
 * &gt; [0.5, 3.3]  # Input another interval.
 * &gt; +           # Pop last two intervals and add them.
 * [1.7, 7.8]    # Output printed by program.
 * &gt;             # End program by entering a blank line.
 */
object Main {
    def main(args: Array[String]) = {
        val stack = new IntervalStack()
        var line: String = ""

        while({ print("> "); line = readLine(); line != "" }) {
            line match {
                case "+" =>
                    try println(stack.pop() + stack.pop())
                    catch {
                        case err: IndexOutOfBoundsException =>
                            println("Not enough elements on stack.")
                    }

                case "-" =>
                    try println(stack.pop() - stack.pop())
                    catch {
                        case err: IndexOutOfBoundsException =>
                            println("Not enough elements on stack.")
                    }

                case "*" =>
                    try println(stack.pop() * stack.pop())
                    catch {
                        case err: IndexOutOfBoundsException =>
                            println("Not enough elements on stack.")
                    }

                case "/" =>
                    try println(stack.pop() / stack.pop())
                    catch {
                        case err: IndexOutOfBoundsException =>
                            println("Not enough elements on stack.")
                        case err: ArithmeticException =>
                            println("Cannot divide by zero.")
                    }

                case  _  =>
                    try stack.push(Interval(line))
                    catch {
                        case err: MatchError =>
                            println("Could not interpret input: " + line)
                            println("Expected input like: " +
                                new Interval().toString)
                    }
            }
        }
    }
}
