#!/usr/bin/env bash
# coding=utf-8

repo_id="dst-$(uuidgen)"

# Create, populate and publish a repository.
steps() {
    pulp-admin rpm repo create --repo-id "${repo_id}" >/dev/null
    pulp-admin rpm repo copy all --from-repo-id src --to-repo-id "${repo_id}" >/dev/null
    pulp-admin rpm repo publish run --repo-id "${repo_id}" >/dev/null
}

# Schedule teardown.
teardown() {
    pulp-admin rpm repo delete --repo-id "${repo_id}" >/dev/null
}
trap teardown EXIT  # bash pseudo signal
trap 'teardown ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
trap 'teardown ; trap - SIGTERM ; kill -s SIGTERM $$' SIGTERM

# Make (the bash builtin) time return values like '5.001' — that's five thousand
# and one milliseconds — instead of prose.
TIMEFORMAT='%E'
# Time prints results to stderr.
(time steps) 2>&1
