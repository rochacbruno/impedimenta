#!/usr/bin/env python

import subprocess

def test_network_connection():
    try:
        output = subprocess.check_output(["ip", "route", "show"])
    except CalledProcessError:
        return False
    if('' == output):
        return False
    else:
        return True

if '__main__' == __name__:
    if(test_network_connection()):
        print "Network connection test suceeded."
    else:
        print "Network connection test failed."
