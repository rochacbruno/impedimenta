nftables
========

Install and configure nftables.

Nftables 0.8 drops support for `/etc/services`, and instead consults an internal
name-to-number mapping. Here's the meaning of the custom services referenced by
this service:

* 21027/udp: Syncthing discovery protocol, for user ichimonji10.
* 21028/udp: Syncthing discovery protocol, for user googoo.
* 22000/tcp: Syncthing core protocol, for user ichimonji10.
* 22001/tcp: Syncthing core protocol, for user googoo.
* 30022/tmp: ssh, for host pine.
* 40035/{tcp,udp}: bittorrent DHT, for host pine.
* 41046/{tcp,udp}: bittorrent data, for host pine.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - nftables
```

A different firewall is installed depending on whether:

* The host is in the "routers" group.
* The host is in the vm-hosts group.
* The host belongs to neither group.
