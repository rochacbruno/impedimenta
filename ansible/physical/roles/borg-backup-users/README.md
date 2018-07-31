borg-backup-users
=================

Configure per-user backups with
[Borg](https://borgbackup.readthedocs.io/en/stable/).

More specifically, do the following:

1.  Install borg.
2.  For each user for which backups should be configured:

    1.  Install a private SSH key at `~/.ssh/borg-backup`
    2.  Customize `~/.ssh/config`.
    3.  Install a script to perform a backup, at `~/.local/bin/borg-backup.sh`.
    4.  Install, start and enable units to periodically call the backup script.
        Note that lingering is _not_ enabled.

The Borg repositories on the remote backup host are distinguished by user names.
As a result, multiple users may back up to the same remote backup host.

Example playbook:

```yaml
- hosts: borg-backup-users-hosts
  roles:
  - borg-backup-users
```

Example variables file:

```yaml
borg_backup_users:
- name: user1
- name: user2
  directories:
  - ~/Documents
  - ~/'my other stuff'
```

Example private variables file:

```yaml
borg_backup_users_passphrases:
  user1: pass1
  user2: pass2
borg_backup_users_private_keys:
  user1: /path/to/key1
  user2: /path/to/key2
```

Variables:

* `borg_backup_users`: Optional, and defaults an empty list. A list of users for
  whom backups will be configured. Each list entry is a dict with the following
  keys:

  * `name`: Required. The name of a user for whom backups will be configured.
  * `directories`: Optional, and defaults to `["~/Documents", "~/Pictures"]`.
    The directories to back up to the remote Borg repository. These directory
    names are subject to Bash's expansion rules. If the directories contain
    whitespace or other interesting characters, consider using single quotes.

* `borg_backup_users_passphrases`: Optional, and defaults to an empty dict. Maps
  user names to the passphrases that those users will use when decrypting the
  remote Borg repository. If a user name is not found in this dict, the backup
  script is not installed.
* `borg_backup_users_private_keys`: Optional, and defaults to an empty dict.
  Maps user names to paths to the paths to the private SSH keys that those users
  will use when SSHing to the remote that hosts the Borg repository.
