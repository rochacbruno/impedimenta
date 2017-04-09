/** Convert short array initializers like {1,2,3} to "\uu0001\u0002\u0003". */
public class ShortToUnicodeString extends ArrayInitBaseListener {
    /** Translate { to ". */
    @Override
    public void enterInit(ArrayInitParser.InitContext ctx) {
        System.out.print('"');
    }

    /** Translate } to ". */
    @Override
    public void exitInit(ArrayInitParser.InitContext ctx) {
        System.out.print('"');
    }

    /** Translate integers to 4-digit hexadecimal strings prefixed with \\u.
      *
      * Assumes no nested array initializers.
      */
    @Override
    public void enterValue(ArrayInitParser.ValueContext ctx) {
        int value = Integer.valueOf(ctx.INT().getText());
        System.out.printf("\\u%04x", value);
    }
}
