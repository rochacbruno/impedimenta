#!/usr/bin/env python

# Create a file, fill it with text, and properly close the filehandle.

from __future__ import print_function
import os

MESSAGE = "Hello, world!\nSecond Line\nThird Line"
FILE    = "myfile.txt"
READ_SIZE = 10 # in bytes

# Create a file and write out a message.
handle = os.open(FILE, os.O_WRONLY | os.O_CREAT)
try:
    os.write(handle, MESSAGE)
finally: 
    os.close(handle)

# Echo the contents of that file.
handle = os.open(FILE, os.O_RDONLY)
try:
    message = os.read(handle, READ_SIZE)
    while(message):
        # file already contains newlines
        print(message, end='')
        message = os.read(handle, READ_SIZE)
finally:
    os.close(handle)

# Delete that file.
os.remove(FILE)
