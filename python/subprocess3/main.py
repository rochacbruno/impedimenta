#!/usr/bin/env python
"""Demonstrate use of subprocess.check_output CalledProcessError exception."""

import subprocess

def iface_up(iface_name):
    """Enable a network interface"""

    print('Bringing up interface {}'.format(iface_name))
    try:
        subprocess.check_output(
            ['ifconfig', iface_name, 'up'],
            stderr = subprocess.STDOUT
        )
        print('Done bringing up interface {}'.format(iface_name))
        return True
    except subprocess.CalledProcessError as err:
        print('Failed to bring up interface {}'.format(iface_name))
        print('Received return code: {}'.format(err.returncode))
        print('Received error message: {}'.format(err.output))
        return False

def iface_down(iface_name):
    """Shut down a network interface."""

    print('Bringing down interface {}'.format(iface_name))
    try:
        subprocess.check_output(
            ['ifconfig', iface_name, 'down'],
            stderr = subprocess.STDOUT
        )
        print('Done bringing down interface {}'.format(iface_name))
        return True
    except subprocess.CalledProcessError as err:
        print('Failed to bring down interface {}'.format(iface_name))
        print('Received return code: {}'.format(err.returncode))
        print('Received error message: {}'.format(err.output))
        return False

def main():
    """Test the functions defined elsewhere in this file."""
    iface_name = 'eth0'

    iface_down(iface_name)
    iface_up(iface_name)

if '__main__' == __name__:
    main()
