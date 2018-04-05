#!/usr/bin/env bash
# coding=utf-8
set -euo pipefail

for domain in $(virsh list --inactive | tail -n +3 | awk '{print $2}'); do
    virsh undefine "${domain}"
done
