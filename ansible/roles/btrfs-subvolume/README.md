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

* `btrfs_path` (required): The path to some directory the btrfs filesystem to
  manage.
* `btrfs_subvolumes` (required): A list of objects, where each object contains
  some information about a subvolume to manage. The following attributes may
  appear in each object.
  * `path` (required): The path to a subvolue, relative to `btrfs_path`.
  * `days` (14): How many days may will old snapshots be retained? Only has an effect
    when `delete` is true.
  * `weeks` (8): How many weeks will old snapshots be retained? Only has an effect
    when `delete` is true.
  * `snapshot` (true): Whether to install subvolume snapshot code.
  * `delete` (true): Whether to instsall subvolume deletion code.

For more information on `days` and `weeks`, see the `btrfs-subvolume-delete.py`
script installed by this role.
