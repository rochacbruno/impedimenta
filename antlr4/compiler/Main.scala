import java.io.FileInputStream
import java.io.InputStream

import org.antlr.v4.runtime.ANTLRInputStream
import org.antlr.v4.runtime.CommonTokenStream
import org.antlr.v4.runtime.tree.ParseTree
import org.antlr.v4.runtime.tree.ParseTreeWalker
import scalax.collection.Graph
import scalax.collection.edge.LDiEdge
import scalax.collection.io.dot._

/** The entry point for this application. */
object Main {
  private val helpMsg: String = "" +
    "Usage:\n" +
    "java -jar Main -help\n" +
    "java -jar Main (-tree | -dot | -liveness | -translate) (file-path | stdin)"

  def main(args: Array[String]): Unit = {
    if (args.length < 1 || args.length > 2) {
        System.err.println("ERROR: Incorrect number of arguments.")
        System.err.println(helpMsg)
        System.exit(1)
    }
    val mode: String = args(0)
    mode match {
      case "-help" =>
        System.out.println(helpMsg)
      case "-tree" =>
        val input: ANTLRInputStream = getANTLRInputStream(args)
        val output: String = doTreeMode(input)
        System.out.println(output)
      case "-dot" =>
        val input: ANTLRInputStream = getANTLRInputStream(args)
        val output: String = doDotMode(input)
        System.out.println(output)
      case "-liveness" =>
        val input: ANTLRInputStream = getANTLRInputStream(args)
        val output: String = doLivenessMode(input)
        System.out.println(output)
      case "-translate" =>
        val input: ANTLRInputStream = getANTLRInputStream(args)
        val output: String = doTranslateMode(input)
        System.out.println(output)
      case _ =>
        System.err.println("ERROR: Flag not recognized: " + mode)
        System.err.println(helpMsg)
        System.exit(1)
    }
  }

  /** Generate a parse tree of the given input. */
  private def doTreeMode(input: ANTLRInputStream): String = {
      val lexer: SimpleLexer = new SimpleLexer(input)
      val tokens: CommonTokenStream = new CommonTokenStream(lexer)
      val parser: SimpleParser = new SimpleParser(tokens)
      val tree: ParseTree = parser.program // parse, starting at program
      tree.toStringTree(parser)
  }

  /** Generate a DOT graph of the CFG of the given input. */
  private def doDotMode(input: ANTLRInputStream): String = {
    val lexer: SimpleLexer = new SimpleLexer(input)
    val tokens: CommonTokenStream = new CommonTokenStream(lexer)
    val parser: SimpleParser = new SimpleParser(tokens)
    val tree: ParseTree = parser.program // parse, starting at program
    val cfg: CFG = new CFGBuilder().visit(tree)

    // See: http://scala-graph.org/guides/dot.html
    val myDotRoot = DotRootGraph(directed=true, id=Some(Id("CFG")))
    def myEdgeTransformer(
        innerEdge: Graph[BasicBlock,LDiEdge]#EdgeT): Option[(DotGraph,DotEdgeStmt)] = {
      innerEdge.edge match {
        case LDiEdge(source, target, label) =>
          // label is one of 'T', 'F' or 'U' (true, false or unconditional)
          Some((myDotRoot, DotEdgeStmt(
              node_1Id=NodeId(source.toString),
              node_2Id=NodeId(target.toString),
              attrList=List(DotAttr(Id("label"), Id(label.toString))),
          )))
      }
    }
    def myCNodeTransformer(
        innerNode: Graph[BasicBlock,LDiEdge]#NodeT): Option[(DotGraph,DotNodeStmt)] = {
      def genLabel(outerNode: BasicBlock): List[String] = {
        val assignmentsText = for (assignment <- outerNode.assignments) yield assignment.getText
        val conditionText = if (outerNode.condition.isDefined) {
          List(outerNode.condition.get.getText)
        } else {
          List()
        }
        List.concat(assignmentsText, conditionText)
      }
      val label: List[String] = genLabel(innerNode.toOuter)
      Some((myDotRoot, DotNodeStmt(
        nodeId=NodeId(innerNode.toString),
        attrList=List(DotAttr(Id("label"), Id(label.toString))),
      )))
    }

    cfg.graph.toDot(
      myDotRoot,
      myEdgeTransformer,
      cNodeTransformer=Some(myCNodeTransformer)
    )
  }

  /**
   * Perform a liveness analysis of the given input.
   *
   * Return a message if any variables might be used without being initialized.
   * In other words, return a message if there are any live variables in the
   * derived control flow graph's entry block.
   */
  private def doLivenessMode(input: ANTLRInputStream): String = {
    val lexer: SimpleLexer = new SimpleLexer(input)
    val tokens: CommonTokenStream = new CommonTokenStream(lexer)
    val parser: SimpleParser = new SimpleParser(tokens)
    val tree: ParseTree = parser.program // parse, starting at program

    val cfg: CFG = new CFGBuilder().visit(tree)
    Analysis.computeLiveness(parser, cfg)
    var message = ""
    if (cfg.entryBlock.live.nonEmpty) {
      message += "The following variables may be used uninitialized => "
      message += cfg.entryBlock.live.reduce(
        (var1: String, var2: String) => s"${var1} ${var2}"
      )
      message += "\n"
    }
    message
  }

  /** Translate the given input to a stack-based assembly-like language. */
  private def doTranslateMode(input: ANTLRInputStream): String = {
    val lexer: SimpleLexer = new SimpleLexer(input)
    val tokens: CommonTokenStream = new CommonTokenStream(lexer)
    val parser: SimpleParser = new SimpleParser(tokens)
    val tree: ParseTree = parser.program // parse, starting at program

    val walker = new ParseTreeWalker()
    val extractor = new TranslatorListener(parser)
    walker.walk(extractor, tree)
    extractor.instructions.reduceLeft(
      (left: String, right: String) => s"${left}\n${right}"
    )
  }

  /** If args(1) is defined, read the named file, else read stdin. */
  private def getANTLRInputStream(args: Array[String]): ANTLRInputStream = {
      val inputStream: InputStream = if (args.length == 1) {
          System.in
      } else {
          new FileInputStream(args(1))
      }
      new ANTLRInputStream(inputStream)
  }
}
