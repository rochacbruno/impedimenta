#!/usr/bin/env python3
# coding=utf-8
# pylint:disable=invalid-name
# It's OK that this script doesn't adhere to snake_case. It's a user-facing
# script.
"""SSH into the currently active Pulp Smash host.

The "currently active" Pulp Smash host is the one named in the Pulp Smash
config file. By default, this file is ``~/.config/pulp_smash/settings.json``.
"""
from subprocess import run

# It's OK that we can't import this module. It's niche.
from pulp_smash import config  # pylint:disable=import-error


def main():
    """SSH into the currently active Pulp Smash host."""
    run(['ssh', config.get_config().hosts[0].hostname])


if __name__ == '__main__':
    exit(main())
