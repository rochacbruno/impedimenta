btrfs-balance
=============

Periodically balance a btrfs filesystem.

Let the balance occur infrequently, such as once a month.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - btrfs-balance
```

Variables
---------

The variables that this role uses, along with their default values, are listed
below.

```yaml
# The path to some directory on a btrfs filesystem. The entire filesystem is
# balanced, even if a sub-directory of the filesystem is specified.
# btrfs_path:
```
