#!/usr/bin/env bash
# uid=1000,gid=100: You have to run this script as root. As a result, the
# mounted directory tree is owned by root. By setting uid and gid, directory
# tree is owned by that user instead. Also, you'll get an I/O error if you
# reference the target machine with it's DNS name instead of it's IP address.
mount -t cifs -o username=FIXME,uid=1000,gid=100 \
    //1.2.3.4/sharename some_local_folder
