#!/usr/bin/env bash
# coding=utf-8
#
# Echo the index of each argument passed to this script, followed by the the
# first five arguments.
set -euo pipefail

echo number of arguments: ${#@}
echo arg 1: "${1:-}"
echo arg 2: "${2:-}"
echo arg 3: "${3:-}"
echo arg 4: "${4:-}"
echo arg 5: "${5:-}"
