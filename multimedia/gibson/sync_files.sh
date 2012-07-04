#!/bin/bash

rsync -azrCv --delete ./jra4098/www/ jra4098@gibson.rit.edu:~/www/
