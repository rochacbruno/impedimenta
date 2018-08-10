docker-nftables
===============

Install Docker, and make compatible with nftables.

"Make compatible" consists of making the firewall reference the logical
interface that Docker creates (via a dependency) and telling Docker to not use
iptables.

For background information, see:

* [Use bridge networks](https://docs.docker.com/network/bridge/)
* [IPv6 on production Docker](https://stephank.nl/p/2017-06-05-ipv6-on-production-docker.html)
