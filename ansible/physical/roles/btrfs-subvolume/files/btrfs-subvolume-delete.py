#!/usr/bin/env python3
# coding=utf-8
# pylint:disable=invalid-name
# It's OK for this module to have an invalid name. It's a shell script, not a
# module to be imported.
"""Delete old Btrfs subvolumes from a given path."""
import argparse
import datetime
import pathlib
import subprocess


def main():
    """Parse arguments, and call other functions as needed."""
    parser = argparse.ArgumentParser(
        description='Delete old btrfs subvolumes.',
        epilog='''
        When this script executes, it will search for files named `path-*`.
        Each file named `path-<iso-8601-string>` is assumed to be a btrfs
        subvolume of `path`, and is considered for deletion. <iso-8601-string>
        is assumed to describe when the snapshot was created. The deletion
        logic is as follows: If the snapshot is less than the given number of
        days, it is kept. Otherwise, if the snapshot is less than the given
        number of weeks and was created on a Wednesday, it is kept. Otherwise,
        the snapshot is deleted.
        ''',
    )
    parser.add_argument(
        'path',
        type=str,
        help='The base path to use when searching for snapshots.',
    )
    parser.add_argument(
        'days',
        type=int,
        help='Snapshots less than this many days old are kept.',
    )
    parser.add_argument(
        'weeks',
        type=int,
        help='''
        Snapshots less than this many weeks old and created on a Wednesday are
        kept.
        ''',
    )
    args = parser.parse_args()
    find_prune_snapshots(args.path, args.days, args.weeks)


def find_prune_snapshots(path, days, weeks):
    """Find and prune snapshots."""
    now = datetime.datetime.now(datetime.timezone.utc)
    ppath = pathlib.PosixPath(path).resolve()
    basename = ppath.parts[-1]
    # For some reason, Pylint thinks that ppath is a PurePath object, instead
    # of a PosixPath object. And PurePath objects don't have a glob() method.
    snapshots = ppath.parent.glob(basename + '-*')  # pylint:disable=no-member
    for snapshot in snapshots:
        created = _get_datetime(snapshot.parts[-1].lstrip(basename + '-'))
        age = now - created
        if age <= datetime.timedelta(days=int(days)):
            continue
        elif (age <= datetime.timedelta(weeks=int(weeks)) and
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
    exit(main())
