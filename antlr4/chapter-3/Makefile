CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  ArrayInitParser.java"
	@echo "    to compile a lexer and parser from ArrayInit.g4"
	@echo "  TestRig"
	@echo "    to run Antlr4's TestRig on sample input"

ArrayInitParser.java:
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool ArrayInit.g4
	CLASSPATH=$(CLASSPATH) javac ArrayInit*.java

TestRig: ArrayInitParser.java
	echo "{1, 2, {3, 4}, 5}" | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig ArrayInit init -gui

.PHONY: help TestRig
