#!/usr/bin/bash
#
# This script is useful for maintaining full backups of a source directory.
#
# New backups are creaed before old ones are removed. New backups have the form
# /mnt/mouse-data/hg-backups/YYYY-MM-DD.tar.bz2. The last 30 backups are kept,
# and anything older is deleted.
N_BACKUPS=30

tar -cj \
    -f /path/to/dest/$(date +%Y-%m-%d).tar.bz2 \
    -C /path/to/src \
    directory
for file in $(ls /path/to/dest | tail -n +$((N_BACKUPS + 1))); do
    rm $file;
done
