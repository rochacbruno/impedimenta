nftables-generic
================

Install and configure nftables.

This role shouldn't be applied to a router.

Example Playbook
----------------

```yaml
- hosts: all:!routers
  roles:
    - nftables
```

The firewall that's installed differs depending on whether the host is in the
following groups:

* bittorrent-hosts
* vm-hosts
* webservers

Additionally, the firewall will be a little bit different if the host name is
`pine.ichimonji10.name`. This bit of customization is hacky, and should be
resolved by making NATted SSH deal with ports in a better way.
