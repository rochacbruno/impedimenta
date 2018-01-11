#!/usr/bin/env bash
# coding=utf-8

# shellcheck disable=SC2034
repo_id="dst-$(uuidgen)"
# shellcheck disable=SC2016
cmds=(
    'pulp-admin rpm repo create --repo-id "${repo_id}" >/dev/null'
    'pulp-admin rpm repo copy all --from-repo-id src --to-repo-id "${repo_id}" >/dev/null'
    'pulp-admin rpm repo publish run --repo-id "${repo_id}" >/dev/null'
    'pulp-admin rpm repo delete --repo-id "${repo_id}" >/dev/null'
)

# Schedule teardown.
teardown() {
    eval "${cmds[-1]}"
}
trap teardown EXIT  # bash pseudo signal
trap 'teardown ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
trap 'teardown ; trap - SIGTERM ; kill -s SIGTERM $$' SIGTERM

# Make (the bash builtin) time return values like '5.001' — that's five thousand
# and one milliseconds — instead of prose. Note that it prints to stderr.
TIMEFORMAT='%E'
declare -a times

# Create, populate and publish a repository.
for cmd in "${cmds[@]}"; do
    times+=( "$(time ( eval "${cmd}" ) 2>&1)" )
done
echo "${times[*]}"
