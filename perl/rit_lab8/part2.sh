#!/bin/sh
# Sample script #1 for Lab 7
FILES=""
DIRS=""

# Classify names
for NAME in * ; do
    if [ -f $NAME ]; then
        FILES="$FILES $NAME"
    elif [ -d $NAME ]; then
        DIRS="$DIRS $NAME"
    fi
done

# Files
echo "Files: "
for FN in $FILES ; do
    echo " $FN"
done

# Directories
echo "Directories: "
for DN in $DIRS ; do
    echo " $DN"
done
