user-subsonic-backup
====================

Create a user, and configure it to back up Subsonic's database.

When executed, this role will do the following:

1. Create a user named `subsonic-backup`.
2. Create several directories in the user's home directory, including one named
   "backups."
3. Install a service unit that, when executed, will create a database rebuild
   script in the "backups" directory. In addition, enable lingering for the
   user, and install, start and enable a timer unit corresponding to the
   just-installed service unit.
4. Create a script called `subsonic-restore.sh` in the user's local executable
   directory. This script can be used to restore Subsonic's database backup.
   Read the script for details. (It should probably be revamped and placed in
   `/usr/local/bin/`.)

No variables are accepted.

---

Why was this role implemented in this manner? Another, less invasive approach is
to avoid creating a second user, and to instead give the subsonic user SSH
access. The subsonic user could then be configured to periodically create dumps
on a remote host. However:

* The subsonic user's home directory contains files installed by the package
  manager and files installed by Subsonic. It would be messy for that directory
  to *also* contain files installed by the sysadmin.
* This only gives us remote backups. It'd be nice to also have local backups
  with btrfs snapshots.
* Giving the subsonic user SSH access seems dangerous. If the user or the
  associated Subsonic application is compromised, it will be able to blow away
  backups, or worse.
* The subsonic user already has access to all users from which it wishes to read
  media.

This role only implements btrfs backups. Afterwards, Borg can also be executed
against this user, so that this user also performs remote SSH backups. This
seems like a more secure approach than overloading the one subsonic user with
too many responsibilities.
