CLASSPATH=".:/usr/share/java/antlr-complete.jar:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  HelloLexer.class"
	@echo "    to compile a lexer and parser from Hello.g4"
	@echo "  TestRig"
	@echo "    to run Antlr4's TestRig on some input"

HelloLexer.class:
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool Hello.g4
	CLASSPATH=$(CLASSPATH) javac *.java

TestRig: HelloLexer.class
	echo "hello world" | CLASSPATH=$(CLASSPATH) \
		java org.antlr.v4.gui.TestRig Hello root -tree

.PHONY: help TestRig
