#!/usr/bin/env python
"""Install 'main' as module MODULE_NAME."""

from distutils.core import setup

setup(
    name = 'foo'              # package metadata
    version = '1.0',          # package metadata
    py_modules = ['main'],    # package contents
)
