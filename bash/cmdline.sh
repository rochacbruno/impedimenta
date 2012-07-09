#!/bin/bash

# The pound sign in ${option#whatever} performs pattern matching. In this case,
# the string "whatever" will be searched for at the begininng of the string. If
# found, delete "whatever" and return the rest. ##, %, and %% all perform
# similar pattern-matching functions.
for option in $(cat /proc/cmdline); do
    case "${option}" in 
        root=*)
            echo ${option#root=}
            ;;
    esac
done
