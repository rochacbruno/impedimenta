# coding=utf-8
"""Custom filters."""
import subprocess


class FilterModule(object):
    """Custom filters."""

    def filters(self):
        """Return custom filters."""
        return {
            'set_escaped_paths': set_escaped_paths,
            'systemd_escape': systemd_escape,
        }


def set_escaped_paths(btrfs_subvolumes):
    """Insert escaped paths into the given dicts.

    Given this data structure::

        [
            {'path': '/foo/bar'},
            {'path': '/biz/baz', 'unrelated': 'data'},
        ]

    Insert ``escaped_path`` into each dict::

        [
            {'path': '/foo/bar', 'escaped_path': '…'},
            {'path': '/biz/baz', 'escaped_path': '…', 'unrelated': 'data'},
        ]

    Return the updated data structure.
    """
    # It should be OK to mutate the arguments to this function, as they're
    # passed in by value, not reference.
    for btrfs_subvolume in btrfs_subvolumes:
        btrfs_subvolume['escaped_path'] = (
            systemd_escape(btrfs_subvolume['path'])
        )
    return btrfs_subvolumes


def systemd_escape(path):
    """Call systemd-escape(1) on the given path, and return the result."""
    return subprocess.check_output(('systemd-escape', '--path', path)).strip()
