#!/usr/bin/env python
"""A simple example of how to define and use a decorator."""

def append_char(func):
    """Decorator. Passed function must return a string."""

    def wrapper():
        """Get string from function in parent. Append characters to string."""
        return '!' + func() + '!'

    return wrapper # Don't call the wrapper here!

@append_char
def get_word():
    """Returns a string."""
    return "electrical"

def main():
    """Suggested entry point for the program."""
    print(get_word())

if '__main__' == __name__:
    main()
