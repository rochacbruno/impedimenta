CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  ExprParser.java"
	@echo "    to compile a lexer and parser from Expr.g4"
	@echo "  TestRig"
	@echo "    to call the compiled lexer and parser from Antlr4's TestRig"

ExprParser.java:
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool Expr.g4
	CLASSPATH=$(CLASSPATH) javac Expr*.java

TestRig: ExprParser.java
	echo '3 + 4' | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig Expr prog -gui

.PHONY: help TestRig
