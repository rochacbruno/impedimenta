import SimpleParser.StatementContext
import SimpleParser.ExprContext

/**
 * A basic block in a control flow graph.
 *
 * A basic block consists of an unbroken sequence of statements, with no
 * logical branches. In this implementation, only assignment statements are
 * tracked, and each assignment statement is "full," containing arbitrarily
 * complex expressions. (The assignments are not, for example SSA form
 * assignments.) Similarly, the condition expression at the end of the basic
 * block is an arbitrarily complex expression.
 *
 * @param assignments The assignment statements in this basic block.
 * @param condition The condition at the end of the basic block, or None if the
 *   block ends with an unconditional jump.
 * @param upwardlyExposed The set of variables used in this block, and not
 *   defined in this block.
 * @param killed The set of variables defined in this block.
 * @param live The set of variables that are live at the end of this block.
 */
class BasicBlock(val assignments    : List[SimpleParser.StatementContext],
                 val condition      : Option[SimpleParser.ExprContext],
                 var upwardlyExposed: Set[String] = Set(),
                 var killed         : Set[String] = Set(),
                 var live           : Set[String] = Set())
