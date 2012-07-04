#!/usr/bin/env python
"""Installer script for project foo."""

from distutils.core import setup

# If not an empty string, installer may give detailed debugging info.
DISTUTILS_DEBUG = ""

setup(
    name = "foo",             # foo-1.0.tar.gz
    version = "1.0",
    py_modules = ["main"],    # "import main"
    author = "Jeremy Audet",
    author_email = "ichimonji10@gmail.com",
    url = "https://github.com/Ichimonji10/impedimenta",
)
