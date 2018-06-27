#!/usr/bin/env python3
# coding=utf-8
"""Define the ansible-review standards for this Ansible code."""
from ansiblereview.examples.standards import (  # pylint:disable=import-error
    become_user_should_have_become,
    host_vars_should_not_be_present,
    standards,
)


# This standard invokes ansible-lint, and asks it to check for ANSIBLE0017.
# Unfortunately, this check doesn't work right. For details, see the comments
# on this topic in the make file.
standards.remove(become_user_should_have_become)

# Host vars are an essential tool. They let us do things like provide interface
# names to the nftables* and netctl* roles.
standards.remove(host_vars_should_not_be_present)
