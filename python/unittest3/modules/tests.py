#!/usr/bin/env python

import unittest
import __init__

class TestFunctions(unittest.TestCase):

    def test_hello_world(self):
        self.assertEqual('Hello, world!', __init__.hello_world())

    def test_reverse(self):
        self.assertEqual('54321', __init__.reverse('12345'))
        self.assertEqual('edcba', __init__.reverse('abcde'))
        self.assertRaises(TypeError, __init__.reverse(["a", "b", "c"]))
        #self.assertRaises(TypeError, reverse(12345)) # wrong error type?

if __name__ == '__main__':
    unittest.main()
