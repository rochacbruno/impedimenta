#!/usr/bin/env python
# coding=utf-8
"""Print the set of unit type IDs on a Pulp server.

Depends on Pulp Smash.
"""
from __future__ import unicode_literals

from pulp_smash import api, config, constants


def main():
    """Talk to the server and print output to stdout."""
    client = api.Client(config.get_config(), api.json_handler)
    unit_types = client.get(constants.PLUGIN_TYPES_PATH)
    unit_type_ids = [unit_type['id'] for unit_type in unit_types]
    unit_type_ids.sort()
    for unit_type_id in unit_type_ids:
        print(unit_type_id)


if __name__ == '__main__':
    main()
