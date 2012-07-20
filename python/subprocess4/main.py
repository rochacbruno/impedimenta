#!/usr/bin/env python
'''Lists the device names of all serial ports on your system.'''

import subprocess
import re

def get_serial_naming_scheme():
    '''Figure out what name prefixes are used for serial devices on this system.

    Serial devices are typically named /dev/ttyS*. However, that's not a strict
    rule. Devices may be named something else. This function returns a tuple of
    prefixes used to name serial devices on this system. For example::

        ('/dev/ttyS', '/dev/cua')
    
    '''
    tty_devices = ''
    device_name = re.compile('^serial *(\S+)')
    device_names = ()

    # Read /proc/tty/drivers
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

    # example of tty_devices contents:
    # serial               /dev/ttyS       4 64-111 serial
    # pty_slave            /dev/pts      136 0-1048575 pty:slave
    for line in tty_devices.splitlines():
        match = device_name.search(line)
        if(match):
            device_names += (match.group(1),)

    return device_names

def get_serial_devices():
    '''Figure out the names of all real serial devices on this system.

    Returns a dict of ``{device_path: settings_dict}`` key:value pairs where
    settings_dict has the following keys:
        
        #. Path
        #. UART
        #. Port
        #. IRQ

    As recently as Ubuntu 11.04, the devices listed in /proc/tty/driver/serial
    did not correspond to real, physical devices. The output of "setserial -g
    /dev/*" was similarly fictitious. Instead, the output showed whatever
    logical configuration the kernel had for things like IRQ addresses and line
    speed.

    Ubuntu 12.04 introduces the use of the serinfo driver. This driver
    automagically determines how many "real" serial devices are present. Here's
    an example from a system with one serial port::

        serinfo:1.0 driver revision:
        0: uart:16550A port:000003F8 irq:4 tx:0 rx:0
        1: uart:unknown port:000002F8 irq:3
        2: uart:unknown port:000003E8 irq:4
        3: uart:unknown port:000002E8 irq:3

    Serial devices are conventionally prefixed /dev/ttyS. Serial devices may
    also exist at /dev/ttyUSB, but logistix is not currently expected to test
    usb-to-serial adapters. The number in the leftmost column above is appended
    to the prefix, so the serial device in the example above is located at
    /dev/ttyS0.

    '''
    proc_devices = ''
    real_devices = {}
    uart_type_re   =  re.compile('uart:(\S+)')
    device_num_re  =  re.compile('^(\d+)')
    port_num_re    =  re.compile('port:(\S+)')
    irq_num_re     =  re.compile('irq:(\S+)')

    # Read /proc/tty/driver/serial
    try:
        proc_devices = subprocess.check_output(
            ['cat', '/proc/tty/driver/serial'],
            stderr = subprocess.STDOUT
        )
    except subprocess.CalledProcessError as err:
        print('Failed to get info about serial devices.')
        print('Received return code: {}'.format(err.returncode))
        print('Received error message: {}'.format(err.output))
        return real_devices

    for line in proc_devices.splitlines():
        # Line may contain spurious output. e.g. "serinfo:1.0 driver revision:"
        match = uart_type_re.search(line)
        if not match:
            continue

        uart_type = match.group(1)
        if(uart_type != 'unknown'):
            # Found a real serial device!
            device_path = '/dev/ttyS' + device_num_re.search(line).group(1)
            real_devices[device_path] = {
                'Path': device_path,
                'UART': uart_type,
                'Port': port_num_re.search(line).group(1),
                'IRQ':  irq_num_re.search(line).group(1),
            }

    return real_devices

def main():
    '''The intended entry point for this program.'''

    print('Serial devices have the following prefixes:\n{}'.format(
        get_serial_naming_scheme()
    ))
    print('The following serial device info was found:\n{}'.format(
        get_serial_devices()
    ))

if '__main__' == __name__:
    main()
