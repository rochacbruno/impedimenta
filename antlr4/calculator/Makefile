CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  ExprParser.java"
	@echo "    to generate a lexer and parser from the Antlr grammar"
	@echo "  ExprParser.java"
	@echo "    to compile a lexer and parser from the Antlr grammar"
	@echo "  TestRig"
	@echo "    to call the lexer and parser from Antlr's TestRig"
	@echo "  Calc.class"
	@echo "    to compile a calculator"
	@echo "  calc"
	@echo "    to run the calculator with sample input"

ExprParser.java: Expr.g4
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool Expr.g4

ExprParser.class: ExprParser.java
	CLASSPATH=$(CLASSPATH) javac Expr*.java

TestRig: ExprParser.class
	echo '3 + 4' | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig Expr prog -gui

Calc.class: ExprParser.class Calc.java
	CLASSPATH=$(CLASSPATH) javac Calc.java

calc: Calc.class
	echo '3 + 4' | CLASSPATH=$(CLASSPATH) java Calc

.PHONY: help calc TestRig
