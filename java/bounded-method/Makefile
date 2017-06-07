help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  compile"
	@echo "    to compile the application"
	@echo "  run"
	@echo "    to run the application"

compile: Main.class

run: compile
	java Main

Box.class: Box.java

Main.class: Main.java Box.class

.PHONY: help compile run

.SUFFIXES: .java .class
.java.class:
	javac -Xlint $(@:.class=.java)
