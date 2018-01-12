check-units
===========

Periodically check for failed units.

If any units have failed, send an email notification.

Usage
-----

Sample usage:

```yaml
- hosts: all
  roles:
    - check-units
```

No variables are accepted.

About
-----

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
