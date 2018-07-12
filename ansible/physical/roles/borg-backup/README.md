borg-backup
===========

Install [Borg](https://borgbackup.readthedocs.io/en/stable/) and configure users
to perform automated periodic backups.

Backups are maintained on a remote host that's available over SSH. A
password-less private SSH key must exist at `~/.ssh/usw-s001.rsync.net`. This
role isn't capable of installing this private SSH key. The system administrator
executing this role must manually install it.

The name of the user that is performing a backup is used as a component of the
remote Borg repository's name. As a result, a user may only have one Borg
repository (per remote host), and multiple users may back up to the same remote
host.

Example playbook:

```yaml
- hosts: borg-backup-hosts
  roles:
  - borg-backup
```

Example variables file:

```yaml
borg_backups:
- user: user1
- user: user2
  directories:
  - ~/Documents
  - ~/'my other stuff'
```

Example private variables file:

```yaml
borg_backup_passphrases:
  user1: pass1
  user2: pass2
```

Variables:

* `borg_backups`: Optional, and defaults to an empty list. A list of users for
  whom backups will be configured. If left empty, only preliminary tasks such as
  installing Borg are performed. Each list entry is a dict with the following
  keys:

  * `user`: Required. A specific user for whom backups will be configured.
    Lingering is enabled for this user.
  * `directories`: Optional, and defaults to `["~/Documents", "~/Pictures"]`.
    The directories to back up to the remote Borg repository. These directory
    names are subject to Bash's expansion rules. If the directories contain
    whitespace or other interesting characters, consider using single quotes.

* `borg_backup_passphrases`: Optional, and defaults to an empty dict. Maps user
  names to the passphrases that those users will use when backing up data to a
  remote Borg repository. If a user name is not found in this dict, some tasks
  are skipped.
