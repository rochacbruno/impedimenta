#!/usr/bin/env bash
set -euo pipefail

readonly plugins=(
    ansicolor
    build-timeout
    cobertura
    config-file-provider
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
    test-stability
    timestamper
    ws-cleanup
    zmq-event-publisher
)
ssh localhost install-plugin ${plugins[*]}
ssh localhost safe-restart
