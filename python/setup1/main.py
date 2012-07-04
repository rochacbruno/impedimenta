#!/usr/bin/env python
"""Simple module which can be installed and imported."""

import time, os

def get_time():
    """Get the current month, day, and year as integers."""
    the_time = time.gmtime()
    return(
        the_time.tm_mon,
        the_time.tm_mday,
        the_time.tm_year,
    )

def get_file_location():
    """Get the absolute path to the location of this file (module)."""
    return(os.path.abspath(os.path.dirname(__file__)))

if '__main__' == __name__:
    print("Date: " + str(get_time()))
    print("File/module location: " + str(get_file_location()))
