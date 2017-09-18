systemd-boot-pacman-hook
========================

Install the
[systemd-boot-pacman-hook](https://aur.archlinux.org/packages/systemd-boot-pacman-hook/)
AUR package.

This role should be applied to all hosts that use
[systemd-boot](https://wiki.archlinux.org/index.php/Systemd-boot).

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - systemd-boot-pacman-hook
```
