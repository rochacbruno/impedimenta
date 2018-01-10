#!/usr/bin/env bash
# Run all of the scripts in this directory in the correct order, and get some
# timing information.
set -euo pipefail

readonly tests=(
    ./test-01.sh
    ./test-02.sh
    ./test-03.sh
)

./setup.sh
for test in "${tests[@]}"; do
    echo Executing "${test}"
    time "${test}"
done
./teardown.sh
