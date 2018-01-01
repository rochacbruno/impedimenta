aur
===

Package and install software from the AUR, using aurutils.

This role is designed to address the needs of an Arch Linux and Ansible user
who'd like to locally package and install packages from the AUR, using aurutils.
When invoked, this role will:

1. Create a user named `aur-packager` and give them passwordless sudo access.
2. Install aurutils.
3. Create a package cache in `/var/cache/pacman/aur/`. Let this cache be owned
   by the `aur-packager` user.
4. Create a repository named `aur`, and make `/etc/pacman.conf` include it.
5. Package and install the AUR packages named by the `aur_packages` variable.
   Let all packaging work be done by the `aur-packager` user.

Sample playbook:

```yaml
- hosts: all
  roles:
    - name: aur
      vars:
        aur_packages:
          - systemd-boot-pacman-hook
```

Known drawbacks:

* Packages aren't built in a chroot. As a result:
  * The build environment may be dirty.
  * The `aur-packager` user requires passwordless sudo access.
* This role is inflexible, and may encounter conflicts. It's impossible to
  configure the user that's used to build packages, the path at which the
  package cache is placed, the name of the repository, or anything else.
* This role doesn't satisfy the needs of an Arch Linux and Ansible user who'd
  like to package and distribute software. (Say, on a LAN.) This role assumes
  that only the local system will use the repository created by this role.
