#!/usr/bin/env bash
set -euo pipefail

readonly plugins=(
    ansicolor
    build-timeout
    cobertura
    config-file-provider
    copyartifact
    credentials-binding
    email-ext
    envinject
    ghprb
    groovy-postbuild
    join
    matrix-combinations-parameter
    ownership
    shiningpanda
    ssh-agent
    ssh-slaves
    test-stability
    timestamper
    ws-cleanup
    zmq-event-publisher
)
ssh localhost install-plugin ${plugins[*]}
ssh localhost safe-restart
