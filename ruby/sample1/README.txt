= CIS-3030 Sample Program 1

This project demonstrates how to create a simple binary search tree using Ruby.
It's based off a binary search tree written in Java for Algorithms & Data
Structures. However, this is not a straight port of Java code: much effort was
put into writing this "the Ruby way". The code is structured differently (e.g.
modules don't exist in Java), Ruby-isms are used (e.g. attr_accessor), and the
docstrings are excellent (try running +rdoc+). Written by Jeremy Audet and Henry
Michael Corse.

Tree.rb::
    Defines the module ``Tree`` and two classes: ``TreeNode`` and ``Tree``.

TestTree.rb::
    Includes unit tests for the ``Tree`` module.

To run unit tests:

    ruby -I . TestTree.rb

To generate documentation:

    rdoc
