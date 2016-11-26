CPU_COUNT=$(shell python -c "from multiprocessing import cpu_count; print(cpu_count())")

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help         to show this message"
	@echo "  lint         to run all linters"
	@echo "  lint-flake8  to run the flake8 linter"
	@echo "  lint-pylint  to run the pylint linter"

lint: lint-flake8 lint-pylint

lint-flake8:
	flake8 .

lint-pylint:
	pylint -j $(CPU_COUNT) --reports=n --disable=I graphs

.PHONY: help lint lint-flake8 lint-pylint
