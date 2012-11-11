import scala.util.parsing.combinator._

class Arith extends JavaTokenParsers {
    def expr:   Parser[Any] = term~rep("+"~term | "-"~term)
    def term:   Parser[Any] = factor~rep("*"~factor | "/"~factor)
    def factor: Parser[Any] = floatingPointNumber | "("~expr~")"
}

class Custom extends RegexParsers {
    def term: Parser[Double] = number~rep("*"~number | "/"~number) ^^ {
        case a~b => {
            var num1 = a
            for(operatorNum <- b) {
                operatorNum match {
                    case "*"~num2 => num1 *= num2
                    case "/"~num2 => num1 /= num2
                }
            }
            num1
        }
    }
    def number: Parser[Double] = """\d+(\.\d+)?""".r ^^ (x => x.toDouble)
}

object Parser extends Custom {
    def main(args: Array[String]) {
        println("input : "+ args(0))
        println(parseAll(term, args(0)))
    }
}
