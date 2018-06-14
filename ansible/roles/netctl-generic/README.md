netctl-generic
==============

Install, configure, start and enable netctl network configuration.

Netctl is Arch Linux's home-brew network configuration manager. It's especially
suitable for relatively static hosts, like headless servers. This role does the
following:

1. Install netctl.
2. If the variable `netctl_generic_external_if` is specified, install a
   configuration file for a profile called "external." If the configuration file
   is changed in any way, also update the corresponding systemd service file.
3. If a configuration file for the "external" netctl profile exists, start and
   enable the corresponding systemd service.

Variables:

* `netctl_generic_external_if`: Optional. The name of the network interface that
  the "external" network profile should manage.
