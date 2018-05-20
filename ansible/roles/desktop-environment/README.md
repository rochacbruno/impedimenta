desktop-environment
===================

Install and configure a GUI desktop environment.

Install applications that are useful in a GUI desktop environment. Start and/or
enable several useful services, such as a login manager and CUPS.

`picocom.yml` installs picocom. As a side effect, it also creates the "uucp"
group. This task is split into a separate file so that it can be executed
independently from the rest of the role with the `include_role` module. Doing so
is not necessary, however, as `main.yml` calls `picocom.yml`.
