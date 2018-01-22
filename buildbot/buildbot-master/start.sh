#!/usr/bin/bash
set -euo pipefail

if [ ! -f state.sqlite ]; then
    buildbot upgrade-master
fi
buildbot start
