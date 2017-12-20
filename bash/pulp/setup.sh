#!/usr/bin/bash
# Create and populate a repository.
set -euo pipefail

pulp-admin login -u admin -p admin
pulp-admin rpm repo create \
    --repo-id src \
    --feed 'https://repos.fedorapeople.org/pulp/pulp/fixtures/rpm-signed/'
pulp-admin rpm repo sync run --repo-id src
