#!/usr/bin/env sh
#
# The procedure for restoring Subsonic is as follows:
#
# 1. Install Subsonic from the AUR. Do *not* start it yet.
# 2. `cd` into the same directory as `subsonic.script` and execute this script.
# 3. Edit ``/var/lib/subsonic/subsonic.sh``, and set the podcasts directory to
#    ``/srv/subsonic/podcasts``. (Optionally, make other tweaks, like for the
#    amount of available memory.
# 4. Start Subsonic.
#
# This script should be run as a user that has write permissions to
# /var/lib/subsonic. Probably root.
set -euo pipefail

install -Dm644 --owner subsonic --group subsonic \
    subsonic.script /var/lib/subsonic/db/subsonic.script
install -d --owner subsonic --group subsonic /var/lib/subsonic/transcode
for transcoder in ffmpeg flac lame; do
    ln -s "$(which "$transcoder")" "/var/lib/subsonic/transcode/${transcoder}"
    chown --no-dereference subsonic: "/var/lib/subsonic/transcode/${transcoder}"
done
install -d --owner subsonic --group subsonic /srv/subsonic/podcasts
