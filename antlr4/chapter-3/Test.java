import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Test {
    public static void main(String[] args) throws Exception {
        // create stream to read from stdin
        ANTLRInputStream input = new ANTLRInputStream(System.in);

        // create lexer to feed from stream
        ArrayInitLexer lexer = new ArrayInitLexer(input);

        // create buffer of tokens from lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // create parser to feed from tokens buffer
        ArrayInitParser parser = new ArrayInitParser(tokens);
        ParseTree tree = parser.init(); // parse from "init" rule

        // Create and launch a generic parse tree walker.
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk(new ShortToUnicodeString(), tree);
        System.out.println(); // print \n
    }
}
