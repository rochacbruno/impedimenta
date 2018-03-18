skillsusa-client
================

Create and configure a user that contestants may use in the ITS competition.

Optional variables:

* `skillsusa_client_private_key`: The path to an SSH private key, to be
  installed into skillsusa-client's ~/.ssh directory. The corresponding public
  key should be installed into skillsusa-server's ~/.ssh directory. This keypair
  allows skillsusa-client to log in to skillsusa-server's account and manage
  VMs.
* `skillsusa_client_public_key`: The path to an SSH public key, to be installed
  into skillsusa-client's ~/.ssh directory. The corresponding private key should
  be installed onto management systems. This keypair allows management systems
  to log in to skillsusa-client's account and perform management tasks.
