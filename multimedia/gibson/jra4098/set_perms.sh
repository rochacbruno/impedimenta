#!/bin/bash

find ./www/ -type d | xargs chmod 755
find ./www/ -type f | xargs chmod 644
