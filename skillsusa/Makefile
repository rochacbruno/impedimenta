lint: lint-ansible-lint lint-shellcheck

lint-ansible-lint:
	ansible-lint ansible/site.yml

lint-shellcheck:
	find . -type f -name '*.sh' -print0 | xargs -0 shellcheck

.PHONY: lint-ansible-lint lint-shellcheck
