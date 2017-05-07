grammar Simple;

program
    : statement+
    ;

statement
    : 'let' ID '=' expr
    ;

expr: expr operand=(MUL|DIV) expr # mulDivExpr
    | expr operand=(ADD|SUB) expr # addSubExpr
    | INT                         # intExpr
    | ID                          # idExpr
    | '(' expr ')'                # parensExpr
    ;

MUL        : '*' ;
DIV        : '/' ;
ADD        : '+' ;
SUB        : '-' ;
ID         : [a-zA-Z]+ ;
INT        : [0-9]+ ;
NEWLINE    : '\r'? '\n' -> skip ;
WHITESPACE : [ \t]+ -> skip ;
