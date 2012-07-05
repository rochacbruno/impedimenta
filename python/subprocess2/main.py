#!/usr/bin/env python

import subprocess

def return_non_zero():
    try:
        output = subprocess.check_output(["false"])
        print "Command returned 0."
    except subprocess.CalledProcessError, err:
        print "Command returned {0}.".format(err.returncode)

if '__main__' == __name__:
    return_non_zero()
