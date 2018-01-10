#!/usr/bin/bash
# Delete repositories created in earlier steps.
set -euo pipefail

pulp-admin rpm repo delete --repo-id src
for i in {1..100}; do
    pulp-admin rpm repo delete --repo-id "dst-${i}"
done
