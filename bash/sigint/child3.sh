#!/usr/bin/env bash
#
# Upon receiving SIGINT, ignore it.
#
set -euo pipefail

echo -n 'child3 start… '
trap -- '' SIGINT
# echo "$(trap -p)"  # Interesting, but cluttersome.
sleep 3
echo end
