#!/usr/bin/env bash
# coding=utf-8
#
# Upon receiving SIGINT, reset SIGINT, and send SIGINT to self. If you want
# to trap SIGINT, perform cleanup, and then pass the SIGINT on to the
# parent, this is the proper way to do it.
#
set -euo pipefail

echo -n 'child1 start… '
trap 'echo "cleanup…" ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
# echo "$(trap -p)"  # Interesting, but cluttersome.
sleep 3
echo end
