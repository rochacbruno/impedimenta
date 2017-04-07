/** Grammars always start with a grammar header.
 *
 * This grammar is called ArrayInit and must match the filename: ArrayInit.g4
 */
grammar ArrayInit ;

init : '{' value (',' value)* '}' ;

value : init
      | INT
      ;

INT : [0-9]+ ;
WS  : [ \t\r\n]+ -> skip ; // drop whitespace
