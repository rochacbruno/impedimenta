#!/bin/bash

# Recursively scan the target directory, $1, for files that have a .markdown
# extension. Generate html files and give them a .html extension. Remove the
# original .markdown files.
if [ -z "$1" ]; then
    echo "Need a directory to recursively scan over."
    exit
fi
find "$1" -type f -name \*.markdown | while read filename; do
    markdown "$filename" > "${filename%markdown}html"
    rm "$filename"
done
