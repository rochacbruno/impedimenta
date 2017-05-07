import scala.collection.mutable.Set

/**
 * Extract ID tokens from a Simple parse tree.
 *
 * Given a parse tree, walk through all of the nodes in that parse tree. Each
 * time an ID token within a primary expression is encountered, place the text
 * representing that token in <code>identifiers</code>.
 */
class IDExtractorListener(parser: SimpleParser) extends SimpleBaseListener {
  val identifiers: Set[String] = Set()

  override def enterIdExpr(ctx: SimpleParser.IdExprContext): Unit = {
    identifiers += ctx.ID.getText
  }
}
