import java.util.HashMap;
import java.util.Map;


/** These methods are called by the parse tree visitor. */
public class EvalVisitor extends ExprBaseVisitor<Integer> {
    /** Calculator registers. Variable/value pairs go here. */
    Map<String, Integer> memory = new HashMap<String, Integer>();

    // ID '=' expr NEWLINE
    @Override
    public Integer visitAssign(ExprParser.AssignContext ctx) {
        String id = ctx.ID().getText();
        int value = visit(ctx.expr());
        memory.put(id, value);
        return value;
    }

    // expr NEWLINE
    @Override
    public Integer visitPrintExpr(ExprParser.PrintExprContext ctx) {
        int value = visit(ctx.expr());
        System.out.println(value);
        return 0; // dummy value
    }

    // INT
    @Override
    public Integer visitInt(ExprParser.IntContext ctx) {
        return Integer.valueOf(ctx.INT().getText());
    }

    // ID
    @Override
    public Integer visitId(ExprParser.IdContext ctx) {
        String id = ctx.ID().getText();
        if (memory.containsKey(id)) {
            return memory.get(id);
        }
        return 0; // dummy value
    }

    // expr ('*'|'/') expr
    @Override
    public Integer visitMulDiv(ExprParser.MulDivContext ctx) {
        int left = visit(ctx.expr(0));
        int right = visit(ctx.expr(1));
        if (ctx.op.getType() == ExprParser.MUL) {
            return left * right;
        }
        return left / right; // Must be ExprParser.DIV
    }

    // expr ('+'|'-') expr
    @Override
    public Integer visitAddSub(ExprParser.AddSubContext ctx) {
        int left = visit(ctx.expr(0));
        int right = visit(ctx.expr(1));
        if (ctx.op.getType() == ExprParser.ADD) {
            return left + right;
        }
        return left - right; // Must be ExprParser.SUB
    }

    // '(' expr ')'
    @Override
    public Integer visitParens(ExprParser.ParensContext ctx) {
        return visit(ctx.expr());
    }
}
