String Matcher
==============

This package contains a program that determines whether or not a given pattern
exists within some given text. It is implemented with the Knuth-Morris-Pratt
algorithm.

Requirements
------------

Python 3 must be available. Only the standard library is used; there are no
third-party dependencies.

Usage
-----

For help, call:

.. code-block:: sh

    python -m string_matcher --help

To execute the program, call:

.. code-block:: sh

   python -m string_matcher "$pattern" "$text"

The program will tell whether or not a match was found, and if so, the indices
at which the matches start.

Regular expressions are not supported. Both ``pattern`` and ``text`` are
interpreted as plain text strings. As a result, this will produce a match:

.. code-block:: sh

   python -m string_matcher '^foo' 'abc^foobar'
