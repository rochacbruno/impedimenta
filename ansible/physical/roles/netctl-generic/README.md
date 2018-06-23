netctl-generic
==============

Install, configure, start and enable netctl network configuration.

Netctl is Arch Linux's home-brew network configuration manager. It's especially
suitable for relatively static hosts, like headless servers. This role does the
following:

1. Install netctl.
2. Install a configuration file for the "external" interface. If the
   configuration file is changed in any way, also update the corresponding
   systemd service file. (This includes initial installation.)
3. Start and enable each of the systemd services.

Required variables:

* `netctl_generic_external_if`: The name of the "external" network interface.
