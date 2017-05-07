import scala.collection.JavaConverters._

import org.antlr.v4.runtime.tree.ParseTreeWalker

/** Methods for analyzing a control flow graph. */
object Analysis {
  /**
   * Compute the liveness of the given graph's nodes.
   *
   * Mutate the <code>live</code> attribute of the given graph's nodes.
   *
   * NOTE: This algorithm differs from the algorithm given in homework #5.
   * Notice that we execute <code>node.live ++= node.upwardlyExposed</code>
   * before iterating through <code>node</code>'s direct successors. This is
   * necessary to detect usages of uninitialized variables in an exit block.
   */
  def computeLiveness(parser: SimpleParser, cfg: CFG): Unit = {
    computeUEAndKillSets(parser, cfg)
    var changed = true
    while (changed) {
      changed = false
      for (node <- cfg.graph.innerNodeTraverser(cfg.graph get cfg.entryBlock)) {
        val oldLive = node.live
        node.live ++= node.upwardlyExposed
        for (successor <- node.diSuccessors) {
          node.live ++= (successor.live -- node.killed)
        }
        if (node.live != oldLive) {
          changed = true
        }
      }
    }
  }

  /**
   * Compute the upwardly exposed and kill sets of the given graph's nodes.
   *
   * Mutate the <code>upwardlyExposed</code> and <code>killed</code> attributes
   * of the given graph's nodes. The attributes should be empty before this
   * method is called.
   */
  private def computeUEAndKillSets(parser: SimpleParser, cfg: CFG): Unit = {
    for (basicBlock  <- cfg.graph.outerNodeTraverser(cfg.graph get cfg.entryBlock);
        statement <- basicBlock.assignments) {
      // Get identifiers from left and right sides of assignment expression.
      // (Discovering identifiers on the left side is so trivial we don't bother
      // using a walker.)
      val walker = new ParseTreeWalker()
      val extractor = new IDExtractorListener(parser)
      walker.walk(extractor, statement.expr)

      // Populate the UE set. (For each identifier on the right side of the
      // assignment expression, if it's not in the kill set, add it to the UE
      // set.)
      val temp = extractor.identifiers -- basicBlock.killed
      basicBlock.upwardlyExposed ++= temp

      // Populate the kill set. (For each identifier on the left side of the
      // assignment expression, add it to the kill set.)
      basicBlock.killed += statement.ID.getText
    }
  }
}
