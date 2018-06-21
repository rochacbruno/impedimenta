CPU_COUNT=$(shell python3 -c "from multiprocessing import cpu_count; print(cpu_count())")

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help                 to show this message"
	@echo "  lint                 to run all linters"
	@echo "  lint-ansible-lint    to run ansible-lint"
	@echo "  lint-ansible-review  to run ansible-review"
	@echo "  lint-pylint          to run pylint"
	@echo "  lint-syntax-check    to run ansible-playbook --syntax-check"

# Don't depend on lint-ansible-review yet, because compliance is a far way off,
# and ansible-review is still being evaluated.
lint: lint-syntax-check lint-ansible-lint lint-pylint

# ANSIBLE0017: become_user requires become to work as expected
#
# ansible-lint doesn't know how to deal with the case where `become_user: ...`
# is applied directly to a task and `become: true` is applied to a task via a
# block statement.
lint-ansible-lint:
	ansible-lint -x ANSIBLE0017 site.yml

lint-ansible-review:
	find . -path './host_vars/*' -print0 -o -type f -name '*.yml' -print0 | xargs -0 ansible-review

lint-pylint:
	find . -type f -name '*.py' -print0 | xargs -0 pylint -j $(CPU_COUNT)

lint-syntax-check:
	ansible-playbook site.yml --syntax-check

.PHONY: help lint lint-ansible-lint lint-ansible-review lint-pylint lint-syntax-check
