#!/usr/bin/env python

import os

UNBUFFERED = 0
NUM_MESSAGES = 10

# fd=file descriptor, fh=file handle
fd_read, fd_write = os.pipe()
fh_read, fh_write = os.fdopen(fd_read, 'r', UNBUFFERED), os.fdopen(fd_write, 'w', UNBUFFERED)
pid = os.fork()
if pid:
    # Parent process. Only reads from child, never writes.
    fh_write.close()
    message = fh_read.readline()
    while(message):
        print "parent read: " + message.strip()
        message = fh_read.readline()
    fh_read.close()
else:
    # Child process. Only writes to parent, never reads.
    fh_read.close()
    for i in range(NUM_MESSAGES):
        print "child writing: hi #%s!" % i
        print >>fh_write, "hi #%s!" % i
        fh_write.flush()
    fh_write.close()
