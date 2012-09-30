#!/bin/bash
#
# Launches MPD if MPD is not already running as the current user.
#

PROGRAM_FOUND=0
PROGRAM_NOT_FOUND=1

pidof `which mpd` > /dev/null
if [ $PROGRAM_NOT_FOUND -eq $? ]
then
    echo 'Starting MPD.'
    mpd
else
    echo 'MPD already running.'
fi
