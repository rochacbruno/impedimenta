#!/usr/bin/env bash
#
# Restore Subsonic's database. To use, execute as root.
set -euo pipefail

systemctl stop subsonic
install -Dm644 --owner subsonic --group subsonic \
    /var/local/subsonic/backups/subsonic.script \
    /var/lib/subsonic/db/subsonic.script
systemctl start subsonic
