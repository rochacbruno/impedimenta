help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  lint"
	@echo "    to lint scripts"
	@echo "  clean"
	@echo "    to remove artifacts"
	@echo "  measurements.txt"
	@echo "    to measure Pulp's performance"

# xargs communicates return values better than find's `-exec` argument.
lint:
	find . -name '*.sh' -print0 | xargs -0 shellcheck

clean:
	rm -f measurements.txt

measurements.txt:
	bin/main.sh $@

.PHONY: help lint clean
