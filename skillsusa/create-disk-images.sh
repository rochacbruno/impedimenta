#!/usr/bin/env bash
# coding=utf-8
#
# Create disk images on the VM server. Run as root.
#
# To the best of my knowledge, neither the virt-manager GUI nor the virsh CLI
# tool implement COW functionality. I've tested this myself, by using
# `virt-clone --reflink …`, and being treated to errors. A reasonable solution
# is to use a "backing file." The idea is to create a virtual machine, and use
# its image as a starting point for clones. There's one *very* important caveat:
# the backing image *must* not be altered after clones are created. Otherwise,
# the clones will be corrupted.
#
# This script creates the clones needed by the 2018 SkillsUSA ITS competition.
# Beware that they're identical to the base images. They must be customized
# after initial creation.
#
# See: https://stackoverflow.com/q/12386398
set -euo pipefail

readonly contestant_ids=(1196 1198 1204 1448 1449 1478)
readonly images_dir=/var/lib/libvirt/images
readonly bases=(
    "${images_dir}/win10-key1.qcow2"
    "${images_dir}/win10-key2.qcow2"
)
for base in "${bases[@]}"; do
    test -e "${base}"
done

# disk management
for contestant_id in "${contestant_ids[@]}"; do
    qemu-img create -f qcow2 -b "${bases[0]}" \
        "${images_dir}/win10-disk-vm1-contestant${contestant_id}.qcow2"
done

# windows shares
for ((i=0; i<${#bases[@]}; i++)); do
    for contestant_id in "${contestant_ids[@]}"; do
        qemu-img create -f qcow2 -b "${bases[$i]}" \
            "${images_dir}/win10-share-vm${i}-contestant${contestant_id}.qcow2"
    done
done

# rdp
for ((i=0; i<${#bases[@]}; i++)); do
    for contestant_id in "${contestant_ids[@]}"; do
        qemu-img create -f qcow2 -b "${bases[$i]}" \
            "${images_dir}/win10-rdp-vm${i}-contestant${contestant_id}.qcow2"
    done
done

# accessibility
for contestant_id in "${contestant_ids[@]}"; do
    qemu-img create -f qcow2 -b "${bases[0]}" \
        "${images_dir}/win10-accessibility-vm1-contestant${contestant_id}.qcow2"
done

# user
for contestant_id in "${contestant_ids[@]}"; do
    qemu-img create -f qcow2 -b "${bases[0]}" \
        "${images_dir}/win10-user-vm1-contestant${contestant_id}.qcow2"
done
