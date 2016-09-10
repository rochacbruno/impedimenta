CPU_COUNT=$(shell python -c "from multiprocessing import cpu_count; print(cpu_count())")

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help         to show this message"
	@echo "  arrays       to generate an 'arrays' directory, where each file"
	@echo "               therein may be passed to 'python -m max_sub'."
	@echo "  clean        to remove generated files"
	@echo "  lint         to run all linters"
	@echo "  lint-flake8  to run the flake8 linter"
	@echo "  lint-pylint  to run the pylint linter"

arrays:
	mkdir arrays
	scripts/gen_arrays.py

clean:
	rm -rf arrays

lint: lint-flake8 lint-pylint

lint-flake8:
	flake8 .

lint-pylint:
	pylint -j $(CPU_COUNT) --reports=n --disable=I max_sub/ scripts/*.py

.PHONY: clean help lint lint-flake8 lint-pylint
