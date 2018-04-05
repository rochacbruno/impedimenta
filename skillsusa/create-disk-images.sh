#!/usr/bin/env bash
# coding=utf-8
#
# Create clones from base images on the VM server. Run this script as root.
#
# To the best of my knowledge, neither the virt-manager GUI nor the virsh CLI
# tool implement COW functionality. I've tested this myself, by using
# `virt-clone --reflink …`, and being treated to errors. A reasonable solution
# is to use a "backing file." The idea is to create a virtual machine, and use
# its image as a starting point for clones. There's one *very* important caveat:
# the backing image *must* not be altered after clones are created. Otherwise,
# the clones will be corrupted. See: https://stackoverflow.com/q/12386398
#
# This script does two things:
#
# 1. Create new disk images, with references to existing backing images on disk.
# 2. Define domains referencing those disk images.
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
    image_path="${images_dir}/win10-disk-vm0-contestant${contestant_id}.qcow2"
    qemu-img create -q -f qcow2 -b "${bases[0]}" "${image_path}"
    chown nobody:kvm "${image_path}"
    echo "${image_path}"
done

# windows shares
for ((i=0; i<${#bases[@]}; i++)); do
    for contestant_id in "${contestant_ids[@]}"; do
        image_path="${images_dir}/win10-share-vm${i}-contestant${contestant_id}.qcow2"
        qemu-img create -q -f qcow2 -b "${bases[$i]}" "${image_path}"
        chown nobody:kvm "${image_path}"
        echo "${image_path}"
    done
done

# rdp
for ((i=0; i<${#bases[@]}; i++)); do
    for contestant_id in "${contestant_ids[@]}"; do
        image_path="${images_dir}/win10-rdp-vm${i}-contestant${contestant_id}.qcow2"
        qemu-img create -q -f qcow2 -b "${bases[$i]}" "${image_path}"
        chown nobody:kvm "${image_path}"
        echo "${image_path}"
    done
done

# accessibility
for contestant_id in "${contestant_ids[@]}"; do
    image_path="${images_dir}/win10-accessibility-vm0-contestant${contestant_id}.qcow2"
    qemu-img create -q -f qcow2 -b "${bases[0]}" "${image_path}"
    chown nobody:kvm "${image_path}"
    echo "${image_path}"
done

# user
for contestant_id in "${contestant_ids[@]}"; do
    image_path="${images_dir}/win10-user-vm0-contestant${contestant_id}.qcow2"
    qemu-img create -q -f qcow2 -b "${bases[0]}" "${image_path}"
    chown nobody:kvm "${image_path}"
    echo "${image_path}"
done
