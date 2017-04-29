import java.io.FileInputStream;
import java.io.InputStream;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;


public class Calc {
    public static void main(String[] args) throws Exception {
        // define input
        String inputFile = null;
        if (args.length > 0) {
            inputFile = args[0];
        }
        InputStream inputStream = System.in;
        if (inputFile != null) {
            inputStream = new FileInputStream(inputFile);
        }
        ANTLRInputStream input = new ANTLRInputStream(inputStream);

        // lex and parse input
        ExprLexer lexer = new ExprLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        ExprParser parser = new ExprParser(tokens);
        ParseTree tree = parser.prog(); // parse, starting at prog

        // emit parse tree
        System.out.println(tree.toStringTree(parser));
    }
}
