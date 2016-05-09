#!/usr/bin/env bash
#
# Upon receiving SIGINT, send SIGINT to self. If you want to trap SIGINT,
# perform cleanup, and pass SIGINT on to the parent, this is *NOT* the
# proper way to do it!
#
set -euo pipefail

echo -n 'child2 start… '
trap 'echo "cleanup…" ; kill -s SIGINT $$' SIGINT
# echo "$(trap -p)"  # Interesting, but cluttersome.
sleep 3
echo end
