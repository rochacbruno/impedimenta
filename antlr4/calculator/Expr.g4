grammar Expr;
import CommonLexerRules;

prog: stat+ ;

stat: expr NEWLINE        # printExpr
    | ID '=' expr NEWLINE # assign
    | 'clear' NEWLINE     # clear
    | NEWLINE             # blank
    ;

expr: expr op=('*'|'/') expr # MulDiv
    | expr op=('+'|'-') expr # AddSub
    | INT                 # int
    | ID                  # id
    | '(' expr ')'        # parens
    ;

MUL : '*' ; // assign name to '*' token used above
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;
