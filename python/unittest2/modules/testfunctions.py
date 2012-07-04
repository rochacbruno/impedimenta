#!/usr/bin/env python

# FUNCTION DEFINITIONS

def hello_world():
    '''Returns "Hello, world!"'''
    return 'Hello, world!'

def reverse(mystring):
    '''Returns a reversed copy of the string passed in.'''
    mylist = list(mystring)
    mylist.reverse()
    return ''.join(mylist)

# UNIT TESTS
import unittest

class TestFunctions(unittest.TestCase):

    def test_hello_world(self):
        self.assertEqual('Hello, world!', hello_world())

    def test_reverse(self):
        self.assertEqual('54321', reverse('12345'))
        self.assertEqual('edcba', reverse('abcde'))
        self.assertRaises(TypeError, reverse(["a", "b", "c"]))
        #self.assertRaises(TypeError, reverse(12345)) # wrong error type?

if __name__ == '__main__':
    unittest.main()
