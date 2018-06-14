nftables-routers
================

Install, configure, start and enable nftables on a router.

Accepted variables:

* `nftables_routers_wan_if`: The name of the WAN network interface.
* `nftables_routers_dmz_if`: The name of the DMZ network interface.
* `nftables_routers_lan_if`: The name of the LAN network interface.
* `nftables_routers_wlan_if`: The name of the WLAN network interface. Nftables
  will be configured to handle both this interface and this interface +
  `_secure`.
