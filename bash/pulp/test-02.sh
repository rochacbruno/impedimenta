#!/usr/bin/bash
# Populate one hundred repositories.
set -euo pipefail

for i in {1..100}; do
    pulp-admin rpm repo copy all --from-repo-id src --to-repo-id "dst-${i}" >/dev/null
done
