help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help"
	@echo "    to show this message"
	@echo "  lint"
	@echo "    to lint scripts"
	@echo "  measurements"
	@echo "    to measure Pulp's performance"

# xargs communicates return values better than find's `-exec` argument.
lint:
	find . -name '*.sh' -print0 | xargs -0 shellcheck

measurements:
	bin/main.sh $@

.PHONY: help lint
