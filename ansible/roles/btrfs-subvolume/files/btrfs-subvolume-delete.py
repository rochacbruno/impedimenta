#!/usr/bin/env python3
# coding=utf-8
"""Delete old Btrfs subvolumes from a given path.

Each subvolume named ``path-<iso-8601-string>`` is considered, and snapshots
with other names are ignored. <iso-8601-string> is assumed to describe when the
snapshot was created. For each snapshot:

1. If the snapshot is less than the given number of weeks, it is kept.
2. If the snapshot is less than the given number of months and was created on a
   Wednesday, it is kept. (A month is assumed to be exactly 30 days.)
3. Otherwise, the snapshot is deleted.

The week and month time-outs are configurable.
"""
import datetime
import pathlib
import subprocess
import sys


def main(path, weeks, months):
    """Find and prune snapshots."""
    now = datetime.datetime.now(datetime.timezone.utc)
    ppath = pathlib.PosixPath(path).resolve()
    basename = ppath.parts[-1]
    snapshots = ppath.parent.glob(basename + '-*')
    for snapshot in snapshots:
        created = _get_datetime(snapshot.parts[-1].lstrip(basename + '-'))
        age = now - created
        if age <= datetime.timedelta(weeks=int(weeks)):
            continue
        elif (age <= datetime.timedelta(days=int(months) * 30) and
                created.isoweekday() == 3):
            continue  # 1–7 == mon–sun
        else:
            subprocess.run(['btrfs', 'subvolume', 'delete', str(snapshot)])


def _get_datetime(timestamp):
    """Parse the given ISO 8601 datetime string.

    :param path: A string like ``2016-08-21T18:03-04:00``. The embedded
        timezone information, if present, may contain a colon (e.g.
        ``-04:00``).
    :returns: An "aware" ``datetime.datetime`` object.
    """
    if timestamp[-3] == ':':
        # root-2016-08-21T18:03-04:00 → root-2016-08-21T18:03-0400
        timestamp = timestamp[:-3] + timestamp[-2:]
    return datetime.datetime.strptime(timestamp, '%Y-%m-%dT%H:%M%z')


if __name__ == '__main__':
    exit(main(*sys.argv[1:]))
