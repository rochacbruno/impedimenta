#!/usr/bin/env python
# A demonstration of how to test modules from the current working directory.
# Does not place functions inside __init__.py

import modules.myfunctions

word = modules.myfunctions.hello_world()
print word
print modules.myfunctions.reverse(word)
print word
