#!/usr/bin/env python

# A simplistic attempt at unit testing and module imports.

import mymodule.string
import unittest

class TestStringEquality(unittest.TestCase):
    def runTest(self):
        self.assertEqual('Hello, world!', mymodule.string.hello_world())

if __name__ == '__main__':
    unittest.main()
