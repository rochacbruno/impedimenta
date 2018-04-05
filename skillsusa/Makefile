lint: lint-ansible-lint lint-shellcheck

lint-ansible-lint:
	ansible-lint ansible/site.yml

lint-shellcheck:
	shellcheck bootstrap-client.sh create-disk-images.sh

.PHONY: lint-ansible-lint lint-shellcheck
