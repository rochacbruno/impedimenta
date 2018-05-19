dynamic-dns
===========

Periodically update dynamic DNS service with current IP addressing information.

Install, start and enable several systemd units, where these units periodically
make HTTP GET calls to a given list of URLs. (A call to one of these special
URLs should be enough to update one dynamic DNS record.) One variable is
accepted: `dynamic_dns_urls`, the list of URLs to make HTTP GET requests to.
