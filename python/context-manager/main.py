#!/usr/bin/env python3
# coding=utf-8
"""Demonstrate how to use a nesting context manager."""


def main():
    """Use ``Indenter`` to print a message."""
    with Indenter() as indent:
        indent.print('hi!')
        with indent:
            indent.print('hello')
            with indent:
                indent.print('bonjour')
        indent.print('hey')


class Indenter(object):  # pylint:disable=too-few-public-methods
    """Further indents printed text each time it's used as a ctx mgr."""

    def __init__(self):
        """Create instance variables."""
        self.indent_level = -1

    def __enter__(self):
        """Increase the indent level."""
        self.indent_level += 1
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Decrease the indent level."""
        self.indent_level -= 1

    def print(self, string):
        """Print the given string with some level of indentation."""
        print(('    ' * self.indent_level) + string)


if __name__ == '__main__':
    exit(main())
