// The *Context objects are a java.util.List, not a scala.List.
import scala.collection.JavaConverters._

import scalax.collection.Graph
import scalax.collection.GraphPredef._
import scalax.collection.edge.LDiEdge

class CFGBuilder extends SimpleBaseVisitor[CFG] {

  override def visitProgram(ctx: SimpleParser.ProgramContext): CFG = {
    combineStatements(ctx.statement.asScala)
  }

  override def visitStatement(
      ctx: SimpleParser.StatementContext): CFG = {
    val block = new BasicBlock(List(ctx), None)
    CFG(Graph(block), block, block)
  }

  private def combineStatements(
      statements: Iterable[SimpleParser.StatementContext]): CFG = {
    val graphList = statements map { visit(_) }
    graphList reduce {(left: CFG, right: CFG) =>
      val CFG(leftGraph, leftEntry, leftExit) = left
      val CFG(rightGraph, rightEntry, rightExit) = right
      CFG(
        (leftGraph union rightGraph) + LDiEdge(leftExit, rightEntry)('U'),
        leftEntry,
        rightExit
      )
    }
  }
}
