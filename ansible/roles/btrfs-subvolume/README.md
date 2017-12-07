btrfs-subvolume
===============

Periodically create and delete snapshots of btrfs subvolumes.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - name: btrfs-subvolume
      vars:
        btrfs_path: /mnt/btrfs
        btrfs_subvolumes:
          - {path: home}
          - {path: srv/ftp, days: 5, weeks: 2}
```

Variables
---------

The variables that this role uses, along with their default values, are listed
below.

```yaml
# The path to some directory on a btrfs filesystem, preferably the root
# directory of the filesystem.
# btrfs_path:
#
# A list of objects, where each object describes a btrfs subvolume to be
# managed. Each object must contain a `path`, which is a relative path from
# `btrfs_path` to the subvolume to be managed. In addition, each object may
# contain `days` (default: 14) and `weeks` (default: 8), which specify how long
# snapshots should be retained for.
# btrfs_subvolumes:
```
