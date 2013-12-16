#!/usr/bin/env sh
#
# Mount a samba share.
#
# For this script to work, the following prerequisites must be met:
# 1. `smbclient` must be installed
# 2. The specified credentials file must exist.
# 3. The specified mount point must exist.
sharename=foo

mount -t cifs //path/to/"$sharename" /mnt/"$sharename"/ \
    -o credentials=/home/username/.samba/"$sharename"_credentials,uid=username,gid=groupname
