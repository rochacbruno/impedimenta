#!/bin/bash
# Recursively look for files in the named directory and print out their names.

TARGET_DIR="$1"
USAGE="Usage: $0 /path/to/dir
Recursively searches dir and prints out the names of all files found."

if [ -z "$1" ]; then
    echo "$USAGE"
elif [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory."
else
    find "$TARGET_DIR" -type f | while read filename; do
        echo "$filename"
    done
fi
