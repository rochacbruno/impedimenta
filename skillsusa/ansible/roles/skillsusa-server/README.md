skillsusa-server
================

Create and configure a user that hosts VMs in the ITS competition.

Optional variables:

* `skillsusa_server_public_key`: The path to an SSH public key, to be installed
  into skillsusa-server's ~/.ssh directory. The corresponding private key should
  be installed into skillsusa-client's ~/.ssh directory. This keypair allows
  skillsusa-client to log in to skillsusa-server's account and manage VMs.
