#!/usr/bin/env python
# Print out a list of all network interfaces on machine, other than loopback.

import subprocess, re

pattern = re.compile('^(\S+)\s+')
for line in subprocess.check_output('ifconfig -a -s', shell=True).splitlines()[1:]:
    match = pattern.search(line)
    if(match and match.group(1) != 'lo'):
        print match.group(1)
