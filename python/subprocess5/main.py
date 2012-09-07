#!/usr/bin/env python

import subprocess
import sys
import time

SUBPROCESS_MAX_RUNTIME = 5

def main():
    print('printing output as it arrives')
    ping_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'google.com',
        ],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
    while(None == ping_thread.poll()):
        print('stdout: {}'.format(
            ping_thread.stdout.readline().rstrip()
        ))
        # oh no!
#        print('stderr: {}'.format(
#            ping_thread.stderr.readline().rstrip()
#        ))
        time.sleep(1)

    print('\ncaching all output before printing')
    ping_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'google.com',
        ],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
    while(None == ping_thread.poll()):
        print('waiting...')
        time.sleep(1)
    print('output: {}'.format(ping_thread.communicate()))

if '__main__' == __name__:
    sys.exit(main())
