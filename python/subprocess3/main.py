#!/usr/bin/env python
"""Demonstrate use of subprocess.check_output CalledProcessError exception."""

import subprocess

INTERFACE_NAME = 'spam'

print('Bringing up interface {}'.format(INTERFACE_NAME))
try:
    subprocess.check_output(
        ['ifconfig', INTERFACE_NAME, 'up'],
        stderr = subprocess.STDOUT)
    print('Done bringing up interface {}'.format(INTERFACE_NAME))
except subprocess.CalledProcessError, err:
    print('Failed to bring up interface {}'.format(INTERFACE_NAME))
    print('Received return code: {}'.format(err.returncode))
    print('Received error message: {}'.format(err.output))
