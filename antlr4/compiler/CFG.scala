import scalax.collection.Graph
import scalax.collection.edge.LDiEdge

/**
 * A control flow graph.
 *
 * A control flow graph consists of a collection of basic blocks connected by
 * edges. A CFG always has an entry block and an exit block, where the entry
 * block has no incoming edges, and the exit block has no outgoing edges. All
 * other nodes have both incoming and outgoing edges.
 *
 * Some of the basic blocks in a CFG have no assignment statements. These "null"
 * blocks are used as to simplify the construction of a CFG. They may or may not
 * be optimized away.
 *
 * Each node in a CFG (except the exit block) has either one or two outgoing
 * edges. If there is only one outgoing edge, it is labeled with 'U', to
 * indicate that it is an unconditional jump. Otherwise, if a node has two
 * outgoing edges, they are labeled with 'T' or 'F', indicating which edge
 * should be followed after evaluating the node's "condition" expression at
 * runtime.
 *
 * @param graph The CFG, including the entry and exit blocks.
 * @param entryBlock The basic block at the entry point of the CFG.
 * @param exitBlock The basic block at the exit point of the CFG.
 */
case class CFG(
  graph: Graph[BasicBlock, LDiEdge],
  entryBlock: BasicBlock,
  exitBlock: BasicBlock)
