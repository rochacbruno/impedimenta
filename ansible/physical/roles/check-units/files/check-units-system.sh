#!/usr/bin/bash
set -euo pipefail

if systemctl --quiet is-failed '*'; then
msmtp -a default jerebear@protonmail.com <<EOF
Subject: There are failed units on $(hostname --long)

$(systemctl --state failed)
EOF
fi
