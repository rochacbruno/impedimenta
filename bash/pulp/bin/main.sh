#!/usr/bin/env bash
# coding=utf-8
set -euo pipefail

# Assume this script has been called from the makefile.
source ./bin/common.sh

# See: http://mywiki.wooledge.org/BashFAQ/028
readonly script_name='main.sh'

# Print usage instructions to stdout.
show_help() {
fmt <<EOF
Usage: ${script_name} [options]

Repeatedly create, populate, publish and delete an RPM repository. Print how
long each step takes.

Options:
    --help
        Show this message.
    --iterations <number>
        Create, populate, publish and delete an RPM repository <number> times.
EOF
}

# Transform $@. $temp is needed. If omitted, non-zero exit codes are ignored.
check_getopt
temp=$(getopt \
    --options '' \
    --longoptions help,iterations: \
    --name "${script_name}" \
    -- "$@")
eval set -- "${temp}"
unset temp

# Read arguments. (getopt inserts -- even when no arguments are passed.)
while true; do
    case "$1" in
        --help) show_help; exit 0;;
        --iterations) iterations="${2}"; shift 2;;
        --) shift; break;;
        *) echo "Internal error! Encountered unexpected argument: $1"; exit 1;;
    esac
done
iterations="${iterations:-10}"

# Schedule teardown.
teardown() {
    set +e
    if [ -n "${temp_file:-}" ]; then
        rm -f "${temp_file}"
    fi
    pulp-admin rpm repo delete --repo-id src >/dev/null
}
trap teardown EXIT  # bash pseudo signal
trap 'teardown ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
trap 'teardown ; trap - SIGTERM ; kill -s SIGTERM $$' SIGTERM

# Do business logic.
pulp-admin login -u admin -p admin >/dev/null
pulp-admin rpm repo create \
    --repo-id src \
    --feed 'https://repos.fedorapeople.org/pulp/pulp/fixtures/rpm-signed/' \
    >/dev/null
pulp-admin rpm repo sync run --repo-id src >/dev/null
for (( i=0; i<iterations; i++ )); do
    ./bin/step.sh
done
