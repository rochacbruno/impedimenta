dnsmasq
=======

Install, configure, start, and enable dnsmasq, for use in a router.

Remember, dnsmasq is "a lightweight DHCP and caching DNS server."

Variables:

* `dnsmasq_lan_if`: The name of the LAN interface.
* `dnsmasq_dmz_if`: The name of the DMZ interface.
* `dnsmasq_wlan_if`: The name of the wireless interface. Dnsmasq will be
  configured to listen on both this interface and this interface + `_secure`.
