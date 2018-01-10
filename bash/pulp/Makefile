help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  lint"
	@echo "    to lint scripts"
	@echo "  clean"
	@echo "    to remove artifacts"
	@echo "  measurements"
	@echo "    to measure Pulp's performance"
	@echo "  measurements.png"
	@echo "    to graph measurements"

# xargs communicates return values better than find's `-exec` argument.
lint:
	find . -name '*.sh' -print0 | xargs -0 shellcheck

clean:
	rm -f measurements measurements.png

measurements:
	bin/main.sh $@

measurements.png: measurements
	bin/plot-measurements.gp > $@

.PHONY: help lint clean
