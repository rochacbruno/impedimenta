#!/usr/bin/python3
# coding=utf-8
# We don't care that this module has an invalid name. It's an executable that
# should never be imported.
# pylint:disable=invalid-name
"""Fiddle with Transmission's configuration file.

Wait for interface tun0 to become available and be initialized with an IPv4
address. Then, set several parameters in Transmission's configuration file. If
no configuration file exists, create one. See the comments in the source code
below for why each setting is set.
"""
import json
import locale
import os
import subprocess
import time


def main():
    """Fiddle with Transmission's configuration file."""
    settings_path = _get_settings_path()
    try:
        with open(settings_path) as handle:
            config = json.load(handle)
    except FileNotFoundError:
        config = {}
    config['bind-address-ipv4'] = _get_tun0_ipv4()

    # Provided by my VPN provider.
    config['peer-port'] = 41046
    config['peer-port-random-on-start'] = False

    # Disable UPnP and NAT-PMP. AFAIK, VPN provider doesn't support them.
    config['port-forwarding-enabled'] = False

    # Require username and password.
    config['rpc-authentication-required'] = True
    config['rpc-bind-address'] = '127.0.0.1'
    config['rpc-username'] = 'admin'
    config['rpc-whitelist-enabled'] = False
    config['rpc-password'] = '{{ transmission_password }}'

    # Avoid uploading much over 1 TB of data per month. God forbid that I use
    # the bandwidth I pay for.
    config['speed-limit-down'] = 1200
    config['speed-limit-down-enabled'] = True
    config['speed-limit-up'] = 400
    config['speed-limit-up-enabled'] = True

    with open(settings_path, 'w') as handle:
        json.dump(config, handle, indent=4, sort_keys=True)


def _get_settings_path():
    """Return the path to transmission's settings file."""
    proc = subprocess.run(
        ('getent', 'passwd', 'transmission'),
        check=True,
        stdout=subprocess.PIPE,
    )
    home_dir = proc.stdout.decode(locale.getpreferredencoding()).split(':')[5]
    return os.path.join(home_dir, '.config/transmission-daemon/settings.json')


def _get_tun0_ipv4():
    """Return the IPv4 address of interface tun0."""
    encoding = locale.getpreferredencoding()
    counter = 0
    limit = 15
    while True:
        proc = subprocess.run(
            ('ip', '-brief', '-family', 'inet', 'addr', 'show', 'dev', 'tun0'),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if proc.returncode == 0:
            break
        if counter > limit:
            raise Exception(
                'Interface tun0 not available after {} seconds. Reason: {}'
                .format(limit, proc.stderr.decode(encoding))
            )
        counter += 1
        time.sleep(1)
    cidr_addr = proc.stdout.decode(encoding).split()[2]
    return cidr_addr.split('/')[0]


if __name__ == '__main__':
    exit(main())
