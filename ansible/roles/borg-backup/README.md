borg-backup
===========

When executed, this role will install
[Borg](https://borgbackup.readthedocs.io/en/stable/) and configure a local user
so that automated backups will occur.

Backups are maintained on a remote system that's available over SSH. A
password-less private SSH key must exist at `~/.ssh/usw-s001.rsync.net`. This
role isn't capable of installing this private SSH key. The system administrator
executing this role must manually install it.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - user-example  # create user before configuring backups for them
    - role: borg-backup
      when: borg_backup_user is defined
      vars:
        borg_backup_user: example
```

Variables
---------

The variables that this role uses, along with their default values, are listed
below:

```yaml
# The local user account for which backups will be configured. This name is a
# component of the name of the Borg repository to which data is backed up.
# Undefined by default. Required.
# borg_backup_user:

# The passphrase for the Borg repository to which data is backed up. Undefined
# by default.
# borg_backup_passphrase:

# These local directories will be backed up to the Borg repository.
borg_backup_directories:
  - ~/Documents
  - ~/Pictures
```
