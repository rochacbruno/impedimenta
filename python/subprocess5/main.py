#!/usr/bin/env python

import subprocess
import sys
import time

SUBPROCESS_MAX_RUNTIME = 5

def main():
    memtester_thread = subprocess.Popen(
        [
            'timeout',
            str(SUBPROCESS_MAX_RUNTIME), # seconds
            'ping',
            'google.com',
        ],
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
    )
    while(None == memtester_thread.poll()):
        print('stdout: {}'.format(
            memtester_thread.stdout.readline().rstrip()
        ))
        # oh no!
#        print('stderr: {}'.format(
#            memtester_thread.stderr.readline().rstrip()
#        ))
        time.sleep(1)

if '__main__' == __name__:
    sys.exit(main())
