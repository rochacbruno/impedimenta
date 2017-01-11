Libvirt Configuration Scripts
=============================

This directory contains scripts for managing a network used by libvirt. The
intended audience is anyone who:

* Wants to have an under-the-hood understanding of how the VMs managed by
  libvirt communicate with the outside world.
* Wants to overcome some of libvirt's `limitations
  <https://jamielinux.com/docs/libvirt-networking-handbook/nat-based-network.html#nat-limitations>`.
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
users can find a good sample configuration `here
<https://jamielinux.com/docs/libvirt-networking-handbook/custom-nat-based-network.html#implement-nat-with-iptables>`.
(That guide references "virbr10" instead of "br-libvirt.")

Configure dnsmasq. dnsmasq should be configured to handle DNS and DHCP requests
**ONLY from interface br-libvirt**. Set at least the following options:

.. code-block:: sh

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

Notes on DNS and DHCP
---------------------

The following is a lengthy set of notes that I created when figuring out how to
provide name services to both the VM host and the VMs. Before proceeding,
understand that the best way to manage networks is to use libvirt's built-in
network management facilities. The following is useful only if:

* You want to manage network services manually, instead of through libvirt.
* You want an in-depth understanding of one aspect of DNS and DHCP.

On my host system, dnsmasq provides DHCP and DNS services to (libvirt) VMs
attached to the br-libvirt (bridge) interface. When a VM is given a DHCP lease,
its hostname is attached to that lease. You can see these mappings in
/var/lib/misc/dnsmasq.leases.

When a DNS lookup request is received on the br-libvirt interface, dnsmasq
handles the request. If the request is for a dotted name such as "example.com",
dnsmasq forwards that request to an upstream DNS server. In contrast, if the
request is for a plain name like "fedora-24-pulp-2-10" is received, it consults
its DHCP leases file, and it returns an IP address or an error as appropriate.
dnsmasq will not forward plain-name lookups to upstream DNS servers so long as
the ``domain-needed`` configuration option is set. (``domain-needed`` and
``bogus-priv`` should almost certainly be set.)

How does dnsmasq find an upstream DNS server? It consults /etc/resolv.conf.
(I'm unsure of whether it consults the file directly or uses libc.) This file
contains entries like ``nameserver 192.168.10.1``. This file is populated by the
resolvconf(8) application.

If dnsmasq has ``interface=br-libvirt`` set in its configuration file, then it
will listen for DHCP and DNS requests on both br-libvirt and the loopback
interface. Given this, it seems logical that DNS lookup requests made by
processes on the host system (hereafter called "local processes") would be
handled by dnsmasq. However, this isn't the case. In reality, local processes
consult with /etc/resolv.conf (via libc) and requests are forwarded to the IP
address(es) listed there.  In our example, local processes send lookup requests
to 192.168.10.1.

How can we ensure that DNS lookup requests from local processes are sent to both
the local dnsmasq daemon and upstream DNS servers, and preferably in that order?

One way to do this is to list 127.0.0.1 at the head of /etc/resolv.conf. When a
local process performs a DNS lookup, that request is sent to 127.0.0.1 and
dnsmasq handles the request. If the name being looked up is in the DHCP leases
file, dnsmasq will respond immediately. Otherwise, dnsmasq will conclude that it
needs to forward the request to an upstream DNS server. It consults
/etc/resolv.conf and forwards the request to one of the listed nameservers.
dnsmasq is smart enough skip the ``nameserver 127.0.0.1`` entry, as it knows
that the request would be received by itself.

How do we get 127.0.0.1 into /etc/resolv.conf? By setting /etc/resolvconf.conf
like so:

.. code-block:: sh

    name_servers=127.0.0.1

This causes resolvconf to prepend ``nameserver 127.0.0.1`` to resolv.conf.
Unfortunately, resolvconf will also assume that this DNS server is a
self-contained name server capable of resolving arbitrary DNS queries *without
consulting /etc/resolv.conf*, and it will write out an /etc/resolv.conf file
like so::

    nameserver 127.0.0.1

This breaks dnsmasq: when it receives a DNS lookup request that cannot be
answered from its local DHCP leases file, it tries to forward the DNS lookup
request to an upstream DNS server — but since /etc/resolv.conf only lists
127.0.0.1 and dnsmasq is smart enough to not forward DNS lookup requests to
itself, the request fails.

The solution is to inform resolvconf that the DNS server at 127.0.0.1 is not, in
fact, a self-contained name server. This is done by removing 127.0.0.1 from the
list of ``local_nameservers`` in /etc/resolvconf.conf, like so:

.. code-block:: sh

    name_servers=127.0.0.1
    local_nameservers=(0.0.0.0 255.255.255.255 ::1)

This will cause resolvconf to generate a resolv.conf file like so::

    nameserver 127.0.0.1
    nameserver 192.168.10.1

This works, but it has some downsides. First: what if libvirt and dnsmasq aren't
always running? This is especially likely on an end-user workstation, where
virtualization services are only sometimes needed. In this case, every DNS
lookup request will be sent to the non-responsive 127.0.0.1 address before being
sent to an upstream DNS server. This is kludgy, and it may have performance
consequences too. Second: do you fully understand the consequences of editing
``local_nameservers``? I certainly don't, and it makes me nervous.

Recall that dnsmasq is listening on interface br-libvirt. Given this fact, a
cleaner approach is to insert br-libvirt's IP address into /etc/resolv.conf when
the br-libvirt interface is created, and to remove br-libvirt's IP address when
the br-libvirt interface is destroyed. resolvconf provides a facility for doing
so. Here's an example of how to insert and remove said entries:

.. code-block:: sh

    echo 'nameserver 192.168.100.1' | resolvconf -a br-libvirt
    resolvconf -d br-libvirt

This should cause resolvconf to generate a resolv.conf file like so::

    nameserver 192.168.100.1
    nameserver 192.168.10.1

We're good, right? Yes, but this configuration is fragile.

When dnsmasq receives a DNS lookup request, it examines /etc/resolv.conf. If it
can answer the request from its DHCP leases file or cache, it immediately does
so. Otherwise, it must forward the DNS lookup request. Where should it forward
the request to? To the only other entry in /etc/resolv.conf, ``192.168.10.1``.
Now, what happens if we join a VPN? In this case, additional routes will be
pushed into /etc/resolv.conf. For example::

    nameserver 192.168.100.1
    nameserver 10.5.30.160
    nameserver 192.168.10.1

In this case, ``10.5.30.160`` is the IP address of a nameserver available in the
VPN. When dnsmasq decides to forward a DNS lookup request, where will that
request go? /etc/dnsmasq.conf has this to say:

> By default, dnsmasq will send queries to any of the upstream servers it knows
> about and tries to favour servers to are known to be up.

In our example, dnsmasq will forward requests to either ``10.5.30.160`` or
``192.168.10.1``. When a DNS lookup is made for a publicly-routable domain, such
as example.com, either nameserver will be able to answer the query. But when a
DNS lookup is made for an internal domain, then:

* If the request is forwarded to ``10.5.30.160``, the IP address of the internal
  domain will be returned.
* If the request is forwarded to ``192.168.10.1``, the an error will be
  returned.

A solution is to set dnsmasq's ``strict-order`` configuration option. This
forces dnsmasq to consider /etc/resolv.conf entries in the order they appear.

In summary, the following dnsmasq configuration is valid:

.. code-block:: sh

    # Never forward plain names (without a dot or domain part)
    domain-needed

    # Never forward addresses in the non-routed address spaces.
    bogus-priv

    # Force dnsmasq to try each query with each server strictly in the order they
    # appear in /etc/resolv.conf
    strict-order

    # If you want dnsmasq to listen for DHCP and DNS requests only on specified
    # interfaces (and the loopback) give the name of the interface (eg eth0) here.
    # Repeat the line for more than one interface.
    interface=br-libvirt

    # Uncomment this to enable the integrated DHCP server, you need to supply the
    # range of addresses available for lease and optionally a lease time. If you
    # have more than one network, you will need to repeat this for each network on
    # which you want to supply DHCP service.
    dhcp-range=192.168.100.2,192.168.100.200,12h

Further Reading
---------------

For more information, see:

* http://wiki.libvirt.org/page/Networking
* https://jamielinux.com/docs/libvirt-networking-handbook/custom-nat-based-network.html
* https://wiki.nftables.org/wiki-nftables/index.php/Performing_Network_Address_Translation_(NAT)
