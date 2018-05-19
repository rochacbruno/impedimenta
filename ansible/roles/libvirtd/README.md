libvirtd
========

Create a virtualization environment with libvirt and QEMU.

Additionally:

* Ensure libvirt can be managed over SSH, with tools such as virt-manager.
* Install additional CLI tools, such as virt-clone and the libguestfs VM
  customization tools.
* Enable IPv4 traffic forwarding.
* If the target is a workstation, install a NetworkManager configuration file
  that forces it to use resolvconf. This lets NetworkManager play nicely with
  the libvirt network management scripts.
* Install, configure, start and enable dnsmasq as a DHCP and DNS server. If the
  target host is not a router, lookups for plain names and non-routable IP
  addresses are forwarded unless the target host is a router. If the target host
  is a workstation, lookup efficiency is degraded for the sake of VPN
  compatibility.

The libvirt network management scripts make a network inteface called
`br-livirt` available to libvirt. This network interface uses the IPv4 range
192.168.101.0/24.
