#!/usr/bin/env bash
#
# This script demonstrates how to properly and improperly handle SIGINT. To
# use, run this script and press C-c at various points. For more
# information, see: https://www.cons.org/cracauer/sigint.html
#
# We intentionally do not `set -euo pipefail` at the beginning of the
# script, as doing so prevents this signal handling exercise from being
# fruitful.

./child1.sh
./child2.sh
./child3.sh
./child4.sh
