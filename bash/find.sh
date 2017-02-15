#!/usr/bin/env bash
#
# Find all directories containing exactly one child.
set -euo pipefail

find . -type d -print0 |
    while IFS= read -r -d $'\0' line; do
        n_files=$(ls "${line}/" | wc -l)
        if (( "$n_files" < 2 )); then
            echo "$n_files $line"
        fi
    done
