#!/bin/sh
#
# A tool for properly ripping DVDs with dd.
# Adapted from: http://www.noah.org/wiki/Dd_-_Destroyer_of_Disks
#
SAMPLE_USAGE="rawread /dev/sr0 > disc.iso"
#
# The naive approach of `dd if=/dev/sr0 of=/my/file.iso` will often result in
# I/O errors or malformed ISOs. This script checks the blocksize and blockcount
# of the source disk before reading, and adds a couple useful flags to dd.
#
# This script may encounter errors when ripping CDs. An alternative (and
# easier!) solution is to use either the readcd or readom tools. For example:
# readcd dev=/dev/sr0 -f=cdrom.iso -notrunc -v

for dependency in dd isoinfo grep cut; do
    which "$dependency" 1>/dev/null 2>/dev/null
    if [ 0 -ne $? ]; then
        echo Missing dependency: "$dependency"
        exit 1
    fi
done

if [ -z $1 ]; then
    echo ERROR: No argument passed to script.
    echo Sample usage: "$SAMPLE_USAGE"
    exit 1
fi
device=$1
if [ ! -b "$device" ]; then
    echo ERROR: "$device" is not a block device.
    exit 1
fi

blocksize=`isoinfo -d -i $device | grep "^Logical block size is:" | cut -d " " -f 5`
if [ "$blocksize" = "" ]; then
    echo catdevice FATAL ERROR: Blank blocksize >&2
    exit 1
fi

blockcount=`isoinfo -d -i $device | grep "^Volume size is:" | cut -d " " -f 4`
if [ "$blockcount" = "" ]; then
    echo catdevice FATAL ERROR: Blank blockcount >&2
    exit 1
fi

command="dd if=$device bs=$blocksize count=$blockcount conv=notrunc,noerror"
echo "$command" >&2
$command
