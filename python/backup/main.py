#!/usr/bin/env python
'''Save a copy of SOURCE_FILE as filename.yyyy-mm-dd in the current directory'''

from datetime import date
from os.path import basename
from subprocess import (
    check_output,
    CalledProcessError,
)
import sys

SOURCE_FILE = ''

def main():
    '''Does the hard work of fetching and saving a file.'''
    # get a copy of the file to be backed up
    try:
        back_me_up = check_output([
            'curl',
            '-s',
            '-f',
            SOURCE_FILE,
        ])
    except CalledProcessError as err:
        print('error fetching file: {}'.format(err))
        return 1

    # what will the backed-up file be named?
    filename = basename(SOURCE_FILE) + '.' + str(date.today())

    # write it out to a file
    with open(filename, 'w') as filehandle:
        filehandle.write(back_me_up)

    # return success
    return None

if '__main__' == __name__:
    sys.exit(main())
