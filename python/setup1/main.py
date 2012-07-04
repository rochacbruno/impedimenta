#!/usr/bin/env python
"""Simple module which can be installed and imported."""

import time

def the_function():
    """Shows current month, day, and year as integers."""
    the_time = time.gmtime()
    print(
        the_time.tm_mon,
        the_time.tm_mday,
        the_time.tm_year,
    )

if '__main__' == __name__:
    the_function()
