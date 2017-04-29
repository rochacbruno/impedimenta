CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  ExprParser.java"
	@echo "    to generate a lexer and parser from the Antlr grammar"
	@echo "  ExprParser.class"
	@echo "    to compile a lexer and parser from the Antlr grammar"
	@echo "  TestRig"
	@echo "    to call the lexer and parser from Antlr's TestRig"
	@echo "  EvalVisitor.class"
	@echo "    to compile EvalVisitor.java"
	@echo "  Calc.class"
	@echo "    to compile a calculator"
	@echo "  calc"
	@echo "    to run the calculator with sample input"

ExprParser.java: Expr.g4
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool -no-listener -visitor Expr.g4

ExprParser.class: ExprParser.java
	CLASSPATH=$(CLASSPATH) javac Expr*.java

TestRig: ExprParser.class
	echo '3 + 4' | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig Expr prog -gui

EvalVisitor.class: ExprParser.class EvalVisitor.java
	CLASSPATH=$(CLASSPATH) javac EvalVisitor.java

Calc.class: EvalVisitor.class Calc.java
	CLASSPATH=$(CLASSPATH) javac Calc.java

calc: Calc.class
	CLASSPATH=$(CLASSPATH) java Calc < math.txt

.PHONY: help calc TestRig
