lexer grammar CommonLexerRules; // not "grammar," but "lexer grammar"

ID      : [a-zA-Z]+ ; // identifier
INT     : [0-9]+ ; // integer
NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ;
