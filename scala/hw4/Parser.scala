import scala.util.parsing.combinator._

/**
 * A parser for simple algebraic expressions. Can deal with floating point
 * numbers, addition, subtraction, multiplication, division, and parentheses.
 */
class Arith extends JavaTokenParsers {
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
    def term: Parser[Double] = factor~rep("*"~factor | "/"~factor) ^^ {
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

    /** The "master" expression that can produce all other symbols. */
    def factor: Parser[Double] = (floatingPointNumber | "("~expr~")") ^^ {
        // FIXME: This is stupid. Scala won't let you call `b.toDouble` or
        // `a.toDouble`, and this is the only workaround I've lit upon.
        case a~b~c => ("" + b).toDouble
        case a     => ("" + a).toDouble
    }
}

/**
 * Calls the parser defined above and passes it <code>args(0)</code>.
 */
object Parser extends Arith {
    def main(args: Array[String]) {
        println("input : "+ args(0))
        println(parseAll(expr, args(0)))
    }
}
