help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help  to show this message"
	@echo "  lint  to run ansible-lint"

# ANSIBLE0017: become_user requires become to work as expected
#
# ansible-lint doesn't know how to deal with the case where `become_user: ...`
# is applied directly to a task and `become: true` is applied to a task via a
# block statement.
lint:
	ansible-lint -x ANSIBLE0017 site.yml

.PHONY: help lint
