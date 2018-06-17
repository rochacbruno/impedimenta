check-units
===========

Periodically check for failed units, on a system-wide or per-user basis.

When executed, this role will install, start and enable units to periodically
check for failed units, plus script for sending notifications when failed units
are found. If `check_units_users` is defined, this is done for the listed users.
Otherwise, this is done for the system-wide instance of systemd.

All users that are to be monitored must exist and belong to the `ichi-machines`
group _before_ this role is called for those users. User creation roles can't
depend on this role.

Usage
-----

To configure system-wide monitoring, place something like the following in a
playbook:

```yaml
- hosts: all
  roles:
    - check-units
```

To configure per-user monitoring, create tasks like the following:

```yaml
- name: Create user
  user:
    name: alice
    groups: ichi-machines

- name: Configure basic unit monitoring for user
  include_role:
    name: check-units
  vars:
    check_units_users:
      - alice
```

Variables
---------

The only accepted variable is `check_units_users`. It's a list of user names.

Extra Information
-----------------

Multiple instances of systemd may be installed on a host. One instance controls
the host as a whole, and this is the instance that has PID 1. Additional
instances may be spawned on a per-user basis. This role configures *very* basic
monitoring for any number of those managers. This role does *not* enable
lingering for the targeted user. Monitoring of a process should not be cause to
start that process; monitoring of a process should only be done when that
process has some other reason to start.

Periodically checking for failed units is a terrible way to monitor the state of
a host. It would be much better to take an event-based approach, where something
is notified as soon as a unit fails. However, this approach is subjectively
better than the alternative monitoring approaches:

1. One could insert `OnFailed=my-notifier.service` statements into units to be
   monitored. (`my-notifier.service` is made up.) See [get notification when
   systemd-monitored service enters failed
   state](https://serverfault.com/q/694818).
2. One could use [sagbescheid](http://sagbescheid.readthedocs.io/en/latest/).
3. One could use [systemd\_mon](https://github.com/joonty/systemd_mon).
4. One could write a custom application that subscribes to events for all units.
   See [How to globally monitor systemd unit
   states?](https://unix.stackexchange.com/q/309250).

However, there are issues with each of these approaches:

1. Using `OnFailed` statements is a white-listing approach, where only certain
   units may be monitored. I want to monitor *all* units. Also, this is a
   dangerous approach, as it's easy to accidentally override an existing
   `OnFailed` statement.
2. sagbescheid doesn't have great docs, it pulls in a worrisomely large number
   of dependencies, the code quality doesn't excite me, it's Python 2 only, and
   it's a very obscure project. In short, I don't trust it enough to put on my
   hosts.
3. systemd\_mon uses a white-listing appraoch, and it's obscure.
4. Writing a custom solution requires a large personal investment.

And that's how we end up with this role. It's dumb, but in my opinion, better
than the alternatives.
