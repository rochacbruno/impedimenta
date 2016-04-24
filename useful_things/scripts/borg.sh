#!/usr/bin/env bash
#
# Create and prune Borg backups. See: http://borgbackup.readthedocs.org. If the
# repository is on a remote system, ensure the SSH key is usable.
#
set -euo pipefail

export BORG_PASSPHRASE=  # passphrase for repository
repository=  # e.g. foo.example.com:borgbackup-myname
archive_prefix="$(hostname --long)"
archive_postfix="$(date --iso-8601=seconds)"

borg create \
    --compression lzma \
    "${repository}::${archive_prefix}-${archive_postfix}" \
    ~/Documents  # FIXME: customize this
borg prune "${repository}" --prefix "${archive_prefix}-" \
    --keep-within 8d --keep-weekly 4 --keep-monthly 6
