import scala.util.parsing.combinator._

/**
 * A parser for simple algebraic expressions. Can deal with floating point
 * numbers, addition, subtraction, multiplication, division, and parentheses.
 */
class Custom extends JavaTokenParsers {
    /**
     * Parses expressions like 2.5~+~1.5~-~4.0. (would return 0.0)
     */
    def expr: Parser[Double] = term~rep("+"~term | "-"~term) ^^ {
        case a~b => {
            var num1 = a
            for(operatorAndNum <- b) {
                operatorAndNum match {
                    case "+"~num2 => num1 += num2
                    case "-"~num2 => num1 -= num2
                }
            }
            num1
        }
    }

    /**
     * Parses expressions like 2.0~*~3.0~/~1.5. (would return 4.0)
     */
    def term: Parser[Double] = number~rep("*"~number | "/"~number) ^^ {
        case a~b => {
            var num1 = a
            for(operatorAndNum <- b) {
                operatorAndNum match {
                    case "*"~num2 => num1 *= num2
                    case "/"~num2 => num1 /= num2
                }
            }
            num1
        }
    }

    // def factor: Parser[Any] = floatingPointNumber | "("~expr~")"
    def number: Parser[Double] = floatingPointNumber ^^ (x => x.toDouble)
}

/**
 * Calls the parser defined above and passes it <code>args(0)</code>.
 */
object Parser extends Custom {
    def main(args: Array[String]) {
        println("input : "+ args(0))
        println(parseAll(expr, args(0)))
    }
}
