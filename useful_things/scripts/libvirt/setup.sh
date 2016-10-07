#!/usr/bin/env bash
#
# READ AND UNDERSTAND THIS SCRIPT BEFORE USING IT!
#
set -xeuo pipefail

# Create a virtual bridge, to which VMs will attach.
#
# A bridge inherits the MAC address of the first interface attached to it. We
# create a dummy network interface and attach it to the bridge to ensure the
# bridge doesn't inherit the MAC address of one of the attached VMs. (What would
# happen if that VM went offline?)
ip link add name br-libvirt type bridge
ip link set br-libvirt up
ip address add local 192.168.100.1/24 dev br-libvirt
mac="$(hexdump -vn3 -e '/3 "52:54:00"' -e '/1 ":%02x"' -e '"\n"' /dev/urandom)"
ip link add name br-libvirt-nic address "$mac" type dummy
ip link set br-libvirt-nic up
ip link set br-libvirt-nic master br-libvirt

# Enable routing.
sysctl -w net.ipv4.ip_forward=1

# Start needed services.
systemctl start dnsmasq libvirtd virtlogd

# vim:set ts=2 sw=2 et:
