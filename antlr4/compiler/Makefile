# The `lib` directory should either contain or link to the following:
#
# * antlr-4.6-complete.jar
# * graph-core_2.12-1.11.5.jar
# * graph-dot_2.12-1.11.5.jar
#
# Other versions of the named jars may be used, but only the versions listed
# above have been tested.
CLASSPATH=".:./lib/*:$$CLASSPATH"

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  grun"
	@echo "    to run ANTLR4's TestRig on simple.txt"
	@echo "  compile"
	@echo "    to compile the application"
	@echo "  run-help"
	@echo "    to run the application with the -help flag"
	@echo "  run-tree"
	@echo "    to run the application with the -tree flag"
	@echo "  run-dot"
	@echo "    to run the application with the -dot flag (pass --silent to make)"
	@echo "  run-liveness"
	@echo "    to run the application with the -liveness flag"
	@echo "  run-translate"
	@echo "    to run the application with the -translate flag"

grun: SimpleParser.class
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.gui.TestRig Simple program -gui < simple.txt

compile: Main.class

run-help: compile
	CLASSPATH=$(CLASSPATH) scala Main -help

run-tree: compile
	CLASSPATH=$(CLASSPATH) scala Main -tree < simple.txt

run-dot: compile
	CLASSPATH=$(CLASSPATH) scala Main -dot < simple.txt

run-liveness: compile
	CLASSPATH=$(CLASSPATH) scala Main -liveness < simple.txt

run-translate: compile
	CLASSPATH=$(CLASSPATH) scala Main -translate < simple.txt

# --------

Analysis.class: Analysis.scala CFG.class IDExtractorListener.class
	CLASSPATH=$(CLASSPATH) scalac Analysis.scala

BasicBlock.class: BasicBlock.scala SimpleParser.class
	CLASSPATH=$(CLASSPATH) scalac BasicBlock.scala

CFG.class: CFG.scala BasicBlock.class
	CLASSPATH=$(CLASSPATH) scalac CFG.scala

CFGBuilder.class: CFGBuilder.scala CFG.class
	CLASSPATH=$(CLASSPATH) scalac CFGBuilder.scala

IDExtractorListener.class: IDExtractorListener.scala SimpleParser.class
	CLASSPATH=$(CLASSPATH) scalac IDExtractorListener.scala

Main.class: Main.scala Analysis.class CFGBuilder.class TranslatorListener.class
	CLASSPATH=$(CLASSPATH) scalac Main.scala

SimpleParser.java: Simple.g4
	CLASSPATH=$(CLASSPATH) java org.antlr.v4.Tool -visitor Simple.g4

SimpleParser.class: SimpleParser.java
	CLASSPATH=$(CLASSPATH) javac Simple*.java

TranslatorListener.class: TranslatorListener.scala SimpleParser.class
	CLASSPATH=$(CLASSPATH) scalac TranslatorListener.scala

.PHONY: help grun translator
