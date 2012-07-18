#!/usr/bin/env python
"""An example of decorators that define arguments."""

def clone(func):
    """Decorator. Passed function must return a string."""

    def wrapper(*args, **kwargs):
        """Get string from function in parent. Append string to itself."""
        return func(*args, **kwargs) * 2

    return wrapper

@clone
def get_word(word = 'electrical'):
    """Returns a string."""
    return word

def main():
    """Suggested entry point for the program."""
    print(get_word())
    print(get_word('tsunami'))

if '__main__' == __name__:
    main()
