Libvirt Configuration Scripts
=============================

This directory contains scripts for managing a network used by libvirt. The
intended audience is anyone who:

* Wants to have an under-the-hood understanding of how the VMs managed by
  libvirt communicate with the outside world.
* Wants to overcome some of libvirt's
  [limitations](https://jamielinux.com/docs/libvirt-networking-handbook/nat-based-network.html#nat-limitations).
  (For example, libvirt assumes iptables is the firewall.)

Preparation
-----------

Before these scripts may be used, some prerequisites must be satisfied. The
exact steps vary widely, but consider taking the following steps:

* Install libvirt.
* Install a libvirt driver, such as QEMU.
* Configure permissions if needed. For example: ``gpasswd --add $(whoami) kvm``.
  Log out and log back in if permissions were updated.
* Ensure hardware virtualization support is enabled in BIOS, if available.
* Install dnsmasq.

Usage
-----

Update your firewall to allow routing from interface br-libvirt, preferably with
(source) NAT. (If NAT is not used, then the network created by the ``setup.sh``
script must be advertised to other networks.) The ``nftables.conf`` script
serves as a good example of what an nftables firewall should look like. iptables
users can find a good sample configuration
[here](https://jamielinux.com/docs/libvirt-networking-handbook/custom-nat-based-network.html#implement-nat-with-iptables).
(That guide references "virbr10" instead of "br-libvirt.")

Configure dnsmasq. dnsmasq should be configured to handle DNS and DHCP requests
**ONLY from interface br-libvirt**. Set at least the following options:

    interface=br-libvirt
    dhcp-range=192.168.100.2,192.168.100.200,12h

    # The following two options make you a better netizen, since they tell
    # dnsmasq to filter out queries which the public DNS cannot answer, and
    # which load the servers (especially the root servers) unnecessarily.
    domain-needed
    bogus-priv

Finally, use the ``setup.sh`` and ``teardown.sh`` scripts. The ``setup.sh``
script creates a virtual bridge, enables routing and starts services. The
``teardown.sh`` script does the reverse.

Further Reading
---------------

For more information, see:

* http://wiki.libvirt.org/page/Networking
* https://jamielinux.com/docs/libvirt-networking-handbook/custom-nat-based-network.html
* https://wiki.nftables.org/wiki-nftables/index.php/Performing_Network_Address_Translation_(NAT)
