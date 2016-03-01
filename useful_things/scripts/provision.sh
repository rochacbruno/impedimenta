#!/usr/bin/env bash
#
# Clone Pulp and several of its plugins, and create a new Vagrant-managed Pulp
# VM with them.
set -euo pipefail

# Clone repositories.
mkdir ~/code/"$PULP"
cd    ~/code/"$PULP"
urls=(
    git@github.com:pulp/pulp{,_{docker,ostree,puppet,python,rpm}}.git
    git@github.com:PulpQE/pulp-smash.git
)
for url in "${urls[@]}"; do
    git clone "${url}"
done

# Edit files and execute `vagrant up`.
cd pulp
cp Vagrantfile{.example,}
echo "$PULP" >> Vagrantfile
echo "$PULP" >> playpen/ansible/vagrant-playbook.yml
vim Vagrantfile playpen/ansible/vagrant-playbook.yml
vagrant up
