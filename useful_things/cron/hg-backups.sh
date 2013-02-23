#!/usr/bin/bash
# This script maintains backups of the mercurial repos on this machine. New
# backups are creaed before old ones are removed. New backups have the form
# /mnt/mouse-data/hg-backups/YYYY-MM-DD.tar.bz2. The last 30 backups are kept,
# and anything older is deleted.

tar -cj -f /mnt/mouse-data/hg-backups/$(date +%Y-%m-%d).tar.bz2 -C /var/lib mercurial-server
for file in $(ls /mnt/mouse-data/hg-backups | tail -n +31); do rm $file; done
