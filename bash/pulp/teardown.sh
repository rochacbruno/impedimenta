#!/usr/bin/bash
# Delete repositories created in earlier steps.
set -euo pipefail

pulp-admin rpm repo delete --repo-id src >/dev/null
for i in {1..100}; do
    pulp-admin rpm repo delete --repo-id "dst-${i}" >/dev/null
done
