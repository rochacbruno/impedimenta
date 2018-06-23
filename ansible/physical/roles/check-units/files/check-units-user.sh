#!/usr/bin/bash
set -euo pipefail

if systemctl --user --quiet is-failed '*'; then
msmtp -a default jerebear@protonmail.com <<EOF
Subject: There are failed units on $(hostname --long) for user $(whoami)

$(systemctl --user --state failed)
EOF
fi
