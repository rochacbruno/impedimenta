#!/usr/bin/env python
'''Lists the device names of all serial ports on your system.'''

# TODO: Have prefixes for device names, cannot yet figure out what devices are
# physically present.

import subprocess
import re

def get_serial_naming_scheme():
    '''Figure out what names are used for serial devices on this system.

    Serial block devices are typically named /dev/ttyS*. However, that's not a
    strict rule. Devices may be named something else. This function returns a
    tuple of prefixes used to name serial devices on this system. For example::

        ('/dev/ttyS', '/dev/cua')
    
    '''
    tty_devices = ''
    device_name = re.compile('^serial *(\S+)')
    device_names = ()

    try:
        tty_devices = subprocess.check_output(
            ['cat', '/proc/tty/drivers'],
            stderr = subprocess.STDOUT
        )
    except subprocess.CalledProcessError as err:
        print('Failed to get info about tty devices.')
        print('Received return code: {}'.format(err.returncode))
        print('Received error message: {}'.format(err.output))
        return device_names

    # Have a list of all tty devices and their names. Get serial tty devices.
    for line in tty_devices.splitlines():
        match = device_name.search(line)
        if(match):
            device_names += (match.group(1),)

    return device_names

def main():
    '''The intended entry point for this program.'''
    print(get_serial_naming_scheme())

if '__main__' == __name__:
    main()
