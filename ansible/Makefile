help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help  to show this message"
	@echo "  lint  to run ansible-lint"

# Ignore this issue because `become: true` is set in ansible.cfg:
#
#     ANSIBLE0017: become_user requires become to work as expected
#
lint:
	ansible-lint -x ANSIBLE0017 manage-services.yml manage-users.yml

.PHONY: help lint
