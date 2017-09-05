#!/usr/bin/python3
# coding=utf-8
# We don't care that this module has an invalid name, since it should never be
# imported. It's an executable
# pylint:disable=invalid-name
"""Fiddle with Transmission's configuration file.

Wait for interface tun0 to become available and be initialized with an IPv4
address. Then, set several parameters in Transmission's configuration file. If
no configuration file exists, create one. Notable settings:

* UPnP and NAP-PMP are disabled. AFAIK, iVPN doesn't support them.
* Distinct directories for incomplete and complete downloads aren't configured.
  This could be desirable because it would help ensure that applications like
  Subsonic don't have to deal with files changing under their feet. But it
  might also interfere with the use case where one wants to download only part
  of a large torrent.

The only option that this script actually needs to set is
``bind-address-ipv4``. The rest could be set by Ansible, or even a human.
They're set here because it's convenient to do so.
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
    config['peer-port'] = 41046
    config['peer-port-random-on-start'] = False
    config['port-forwarding-enabled'] = False
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