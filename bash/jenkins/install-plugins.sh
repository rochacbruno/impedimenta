#!/usr/bin/env bash
set -euo pipefail

readonly plugins=(
    ansicolor
    cobertura
    config-file-provider
    envinject
    ghprb
    groovy-postbuild
    join
    matrix-combinations-parameter
    ownership
    shiningpanda
    ssh-agent
    test-stability
    zmq-event-publisher
)
ssh localhost install-plugin ${plugins[*]}
ssh localhost safe-restart
