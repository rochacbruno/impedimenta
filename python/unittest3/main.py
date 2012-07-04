#!/usr/bin/env python
# A demonstration of how to test modules from the current working directory.
# Does place functions inside __init__.py

import modules

word = modules.hello_world()
print word
print modules.reverse(word)
print word
