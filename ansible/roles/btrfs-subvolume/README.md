btrfs-subvolume
===============

Periodically create and delete snapshots of btrfs subvolumes.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - btrfs-subvolume
```

Variables
---------

The variables that this role uses, along with their default values, are listed
below.

```yaml
# The path to some directory on a btrfs filesystem, preferably the root
# directory of the filesystem. Paths to subvolumes are calculated relative to
# this path.
# btrfs_path:
```
