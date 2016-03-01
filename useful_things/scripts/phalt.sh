#!/usr/bin/env sh
#
# Halt a Vagrant-managed Pulp VM that has been rolled back from 2.8 to 2.7.

touch playpen/bootstrap-ansible.sh
install -D /dev/null playpen/ansible/vagrant-playbook.yml
vagrant halt
