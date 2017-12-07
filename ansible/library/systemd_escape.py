#!/usr/bin/python3
"""Given a path, return a systemd-escape(1) version."""
from ansible.module_utils.basic import AnsibleModule


def main():
    """Implement module logic."""
    # This module makes no changes to hosts. Therefore, it supports check mode.
    module = AnsibleModule(
        argument_spec={'path': {'required': True, 'type': 'str'}},
        supports_check_mode=True,
    )
    escaped_path = module.run_command([
        'systemd-escape',
        '--path',
        module.params['path'],
    ])[1].strip()
    module.exit_json(changed=False, escaped_path=escaped_path)


if __name__ == '__main__':
    exit(main())
