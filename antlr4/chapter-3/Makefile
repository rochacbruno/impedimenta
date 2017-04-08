CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  ArrayInitParser.java"
	@echo "    to compile a lexer and parser from ArrayInit.g4"
	@echo "  TestRig"
	@echo "    to call the compiled lexer and parser from Antlr4's TestRig"
	@echo "  Test.class"
	@echo "    to compile Test.java"
	@echo "  Test"
	@echo "    to call the Test program with sample input"

ArrayInitParser.java:
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool ArrayInit.g4
	CLASSPATH=$(CLASSPATH) javac ArrayInit*.java

TestRig: ArrayInitParser.java
	echo "{1, 2, {3, 4}, 5}" | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig ArrayInit init -gui

Test.class: ArrayInitParser.java
	CLASSPATH=$(CLASSPATH) javac Test.java

Test: Test.class
	echo "{1, 2, {3, 4}, 5}" | CLASSPATH=$(CLASSPATH) java Test

.PHONY: help TestRig Test
