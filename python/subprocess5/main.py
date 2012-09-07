#!/usr/bin/env python

import subprocess
import sys
import time

SUBPROCESS_MAX_RUNTIME = 3

def main():
    print('printing output as it arrives')
    ping_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'localhost',
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
    print('return code: {}'.format(ping_thread.poll()))
    print('return code: {}'.format(ping_thread.poll()))

    print('\ncaching all output before printing')
    ping_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'localhost',
        ],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
    while(None == ping_thread.poll()):
        print('waiting...')
        time.sleep(1)
    print('output: {}'.format(ping_thread.communicate()))
    print('return code: {}'.format(ping_thread.poll()))

    print('\nallowing process to terminate nicely, then polling retval twice')
    ping_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'localhost',
            '-c',
            '1',
        ],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
    while(None == ping_thread.poll()):
        print('waiting...')
        time.sleep(1)
    print('output: {}'.format(ping_thread.communicate()))
    print('return code: {}'.format(ping_thread.poll()))
    print('return code: {}'.format(ping_thread.poll()))

if '__main__' == __name__:
    sys.exit(main())
