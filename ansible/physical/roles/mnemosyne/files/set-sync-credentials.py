#!/usr/bin/env python3
# coding=utf-8
# pylint:disable=invalid-name
# It's OK for this module to have an invalid name. It's a shell script, not a
# module to be imported.
"""Set sync server credentials in mnemosyne's database.

This script is adapted from ` User and password for syncing overwritten when
running with --sync-server
<https://bugs.launchpad.net/mnemosyne-proj/+bug/1644402>`_.
"""
import argparse
import sqlite3


def main():
    """Parse arguments, and call other functions as needed."""
    parser = argparse.ArgumentParser(
        description="Set sync server credentials in mnemosyne's database.",
    )
    # There's little point in setting `type` to a function that verifies the
    # presence of the specified database. That's a recipe for race conditions.
    # If a pretty user-facing error messages are to be presented, it's probably
    # better to catch a file-opening exception.
    parser.add_argument(
        'database',
        type=str,
        help='The path to a mnemosyne database file.'
    )
    parser.add_argument(
        'username',
        type=str,
        help='The username that clients must present to the sync server.',
    )
    parser.add_argument(
        'password',
        type=str,
        help='The password that clients must present to the sync server.',
    )
    args = parser.parse_args()
    set_sync_credentials(args.database, args.username, args.password)


def set_sync_credentials(database, username, password):
    """Set sync server credentials in mnemosyne's database."""
    connection = sqlite3.connect(database)
    try:
        with connection:
            connection.execute(
                'select * from config '
                'where key like "%remote%"'
            )
            connection.execute(
                'update config set value = "{!r}" '
                'where key = "remote_access_username"'
                .format(username)
            )
            connection.execute(
                'update config set value = "{!r}" '
                'where key = "remote_access_password"'
                .format(password)
            )
    finally:
        connection.close()


if __name__ == '__main__':
    exit(main())
