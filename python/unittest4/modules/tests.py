#!/usr/bin/env python

import unittest
import myfunctions

class TestFunctions(unittest.TestCase):

    def test_hello_world(self):
        self.assertEqual('Hello, world!', myfunctions.hello_world())

    def test_reverse(self):
        self.assertEqual('54321', myfunctions.reverse('12345'))
        self.assertEqual('edcba', myfunctions.reverse('abcde'))
        self.assertRaises(TypeError, myfunctions.reverse(["a", "b", "c"]))

if __name__ == '__main__':
    unittest.main()
