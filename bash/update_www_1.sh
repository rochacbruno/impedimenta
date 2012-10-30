#!/bin/bash
# Update the www_1 folder, convert markdown files therein to HTML, and link www
# to www_1.

cd /media/external1/lighttpd
bzr clean-tree --detritus --force --directory www_1
bzr update www_1
find "www_1" -type f -name \*.markdown | while read filename; do
    ./populate_template.py ./templates/default.html "$filename" > "${filename%markdown}html"
done
ln -snf ./www_1 ./www
