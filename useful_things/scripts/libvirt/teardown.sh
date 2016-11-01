#!/usr/bin/env bash
#
# READ AND UNDERSTAND THIS SCRIPT BEFORE USING IT!
#
set -xeuo pipefail

# Don't send DNS name lookups to dnsmasq.
resolvconf -d br-libvirt

# Stop services.
systemctl stop dnsmasq libvirtd virtlogd

# Disable IPv4 forwarding.
sysctl -w net.ipv4.ip_forward=0

# Destroy the dummy network interface and bridge.
ip link set br-libvirt-nic nomaster
ip link set br-libvirt-nic down
ip link delete br-libvirt-nic type dummy
ip link set br-libvirt down
ip link delete br-libvirt type bridge

# vim:set ts=2 sw=2 et:
