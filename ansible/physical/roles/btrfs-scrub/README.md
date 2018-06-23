btrfs-scrub
=============

Periodically scrub a btrfs filesystem.

Let the scrub occur infrequently, such as once a month.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - btrfs-scrub
```

Variables
---------

The variables that this role uses, along with their default values, are listed
below.

```yaml
# The path to some directory on a btrfs filesystem. The entire filesystem is
# scrubbed, even if a sub-directory of the filesystem is specified.
# btrfs_path:
```
