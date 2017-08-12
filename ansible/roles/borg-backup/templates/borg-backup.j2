#!/usr/bin/env bash
#
# Create and prune Borg backups. See: http://borgbackup.readthedocs.org. Ensure
# the SSH key is usable.
set -euo pipefail

export BORG_PASSPHRASE='{{ borg_backup_passphrase }}'
repository=usw-s001.rsync.net:borgbackup-{{ borg_backup_user }}
archive_prefix="$(hostname --short)"
archive_postfix="$(date --iso-8601=seconds)"

# As of this writing, `ssh hostname borg --version` returns 0.29.0.
export BORG_REMOTE_PATH=/usr/local/bin/borg1/borg1

borg create \
    --compression lzma \
    "${repository}::${archive_prefix}-${archive_postfix}" \
    {% for directory in borg_backup_directories %} {{ directory }} {% endfor %}

borg prune "${repository}" --prefix "${archive_prefix}-" \
    --keep-within 8d --keep-weekly 4 --keep-monthly 6
