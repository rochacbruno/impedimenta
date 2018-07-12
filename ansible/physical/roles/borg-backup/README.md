borg-backup
===========

When executed, this role will install
[Borg](https://borgbackup.readthedocs.io/en/stable/) and configure a local user
so that automated backups will occur.

Backups are maintained on a remote system that's available over SSH. A
password-less private SSH key must exist at `~/.ssh/usw-s001.rsync.net`. This
role isn't capable of installing this private SSH key. The system administrator
executing this role must manually install it.

The user's name, as defined by the `borg_backup_user`, is used as a component of
the remote Borg repository's name. As a result, a user may only have one
repository on a remote host, and multiple users may back up to the same remote
host.

Example playbook:

```yaml
- hosts: all
  roles:
  - user-my-user  # create user before configuring backups for them
  - role: borg-backup
    when: borg_backup_user is defined
    vars:
      borg_backup_user: my-user
      borg_backup_directories:
      - ~/Documents
      - ~/'my other stuff'
```

Variables:

* `borg_backup_user`: Required. The local user who will perform backups.
  Lingering is enabled for this user.
* `borg_backup_passphrase`: Optional, and defaults to undefined. The passphrase
  for the Borg repository to which data is backed up. If undefined, some tasks
  are skipped.
* `borg_backup_directories`: Optional, and defaults to `["~/Documents",
  "~/Pictures"]`. The directories to back up to the remote Borg repository.
  These directory names are subject to Bash's expansion rules. If the
  directories contain whitespace or other interesting characters, consider using
  single quotes.
