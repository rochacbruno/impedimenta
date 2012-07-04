#!/usr/bin/env python
"""Installer script for module idontevenknowitseducational."""

from distutils.core import setup

# If not an empty string, installer may give detailed debugging info.
DISTUTILS_DEBUG = ""

setup(
    name = "foo",             # name of package
    version = "1.0",          # package release version
    py_modules = ["main"],    # modules in package
    author = "Jeremy Audet",
    author_email = "ichimonji10@gmail.com",
    url = "https://github.com/Ichimonji10/impedimenta",
)
