openvpn-client-ivpn
===================

Install OpenVPN, and configure for split routing.

When connecting to the VPN, don't accept routes pushed by the server. Instead,
only make traffic with a source address equal to that of the tunnel interface go
through the VPN.

Optional variables are `openvpn_client_ivpn_username` and
`openvpn_client_ivpn_password`.
