#!/usr/bin/bash
# coding=utf-8
set -euo pipefail

readonly specfiles=(
    1-files.spec
    10-files.spec
    100-files.spec
    1000-files.spec
)

# Populate ~/rpmbuild/SRPMS/
rpmdev-setuptree
for specfile in "${specfiles[@]}"; do
    rpmbuild -bs --target fc26 "specfiles/${specfile}" &
done
wait

# The available environments are defined in /etc/mock/.
mock --root fedora-26-x86_64 --init
for specfile in "${specfiles[@]}"; do
    # Build file in /var/lib/mock/.../result/
    filename="$(rpm --query --queryformat '%{NEVR}.src.rpm' --specfile "specfiles/${specfile}")"
    mock --root fedora-26-x86_64 ~/rpmbuild/SRPMS/"${filename}"

    filename="$(rpm --query --queryformat '%{NEVRA}.rpm' --specfile "specfiles/${specfile}")"
    cp /var/lib/mock/fedora-26-x86_64/result/"${filename}" .
done
