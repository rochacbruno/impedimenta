#!/usr/bin/env python

def hello_world():
    '''Returns "Hello, world!"'''
    return 'Hello, world!'

def reverse(mystring):
    '''Returns a reversed copy of the string passed in.'''
    mylist = list(mystring)
    mylist.reverse()
    return ''.join(mylist)
