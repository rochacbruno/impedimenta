import scala.collection.mutable.ListBuffer

/** Translate Simple-compliant code to stack-based instructions. */
class TranslatorListener(parser: SimpleParser) extends SimpleBaseListener {
  val instructions: ListBuffer[String] = ListBuffer[String]()

  override def enterStatement(ctx: SimpleParser.StatementContext): Unit = {
    instructions += s"; ${ctx.getText}"
  }

  override def exitStatement(ctx: SimpleParser.StatementContext): Unit = {
    instructions += s"POP ${ctx.ID.getText}\n"
  }

  override def exitMulDivExpr(ctx: SimpleParser.MulDivExprContext): Unit = {
    ctx.operand.getType match {
      case SimpleParser.MUL =>
        instructions += "MULT"
      case SimpleParser.DIV =>
        instructions += "DIV"
      case _ =>
        instructions += s"ERROR: Unknown operand: ${ctx.operand.getText}"
    }
  }

  override def exitAddSubExpr(ctx: SimpleParser.AddSubExprContext): Unit = {
    ctx.operand.getType match {
      case SimpleParser.ADD =>
        instructions += "ADD"
      case SimpleParser.SUB =>
        instructions += "SUB"
      case _ =>
        instructions += s"ERROR: Unknown operand: ${ctx.operand.getText}"
    }
  }

  override def enterIntExpr(ctx: SimpleParser.IntExprContext): Unit = {
    instructions += s"PUSH ${ctx.INT.getText}"
  }

  override def enterIdExpr(ctx: SimpleParser.IdExprContext): Unit = {
    instructions += s"PUSH ${ctx.ID.getText}"
  }
}
