#!/usr/bin/bash
# Create one hundred repositories.
set -euo pipefail

for i in {1..100}; do
    pulp-admin rpm repo create --repo-id "dst-${i}"
done
