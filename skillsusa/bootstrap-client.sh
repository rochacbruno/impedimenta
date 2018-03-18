#!/usr/bin/env bash
#
# Run as root. Ensure a file named "skillsusa-client.pub" is in the current
# directory.
set -euo pipefail

skillsusa_client_home="$(getent passwd skillsusa-client | awk -F : '{print $6}')"
install \
    --directory \
    --owner skillsusa-client \
    --group skillsusa-client \
    --mode 700 \
    "${skillsusa_client_home}/.ssh/"
install \
    --owner skillsusa-client \
    --group skillsusa-client \
    --mode 600 \
    skillsusa-client.pub \
    "${skillsusa_client_home}/.ssh/authorized_keys"
apt-get --yes install openssh-server
systemctl enable --now ssh
