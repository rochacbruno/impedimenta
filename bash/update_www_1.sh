#!/bin/bash
# Update the $HTML_DEST folder, convert markdown files therein to HTML, and link
# www to $HTML_DEST.

HTML_DEST="www_1"

cd /media/external1/lighttpd
for dir in $HTML_DEST templates; do
    bzr clean-tree --detritus --force --directory $dir
    bzr update $dir
done
find "$HTML_DEST" -type f -name \*.markdown | while read filename; do
    ./populate_template.py ./templates/default.html "$filename" > "${filename%markdown}html"
done
ln -snf "$HTML_DEST" www
