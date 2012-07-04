#!/usr/bin/env python
# A better designed demonstration of module testing than unittest1.

import modules.testfunctions

word = modules.testfunctions.hello_world()
print word
print modules.testfunctions.reverse(word)
print word
