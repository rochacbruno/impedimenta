#!/usr/bin/env python
"""Desmonstrates several techniques for creating pathnames."""

import os
import sys

print os.getcwd()
print os.path.dirname(__file__)
print os.path.abspath(os.path.dirname(__file__))
print os.path.join(os.path.abspath(os.path.dirname(__file__)), 'testdir')
print os.path.join(os.path.abspath(os.path.dirname(__file__)), 'testdir/subdir')
