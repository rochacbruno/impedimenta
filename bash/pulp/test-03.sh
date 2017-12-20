#!/usr/bin/bash
# Publish one hundred repositories.
set -euo pipefail

for i in {1..100}; do
    pulp-admin rpm repo publish run --repo-id "dst-${i}" &
done
wait
