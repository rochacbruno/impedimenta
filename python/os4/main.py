#!/usr/bin/env python
"""Desmonstrates several techniques for creating pathnames."""

import os
import sys

print('cwd')
print(os.getcwd())
print('\npath to file')
print(__file__)
print(os.path.abspath(__file__))
print('\npath to container dir')
print(os.path.dirname(__file__))
print(os.path.abspath(os.path.dirname(__file__)))
print('\npath to neighboring dir')
print(os.path.join(
    os.path.dirname(__file__),
    'testdir',
    'subdir',
))
print(os.path.abspath(os.path.join(
    os.path.dirname(__file__),
    'testdir',
    'subdir',
)))
print('\nwalking up filesystem')
print(os.path.abspath(
    __file__,
))
print(os.path.abspath(os.path.join(
    __file__,
    '..',
)))
print(os.path.abspath(os.path.join(
    __file__,
    '..',
    '..',
)))
print(os.path.abspath(os.path.join(
    __file__,
    '..',
    '..',
    'testdir',
    'subdir',
)))
