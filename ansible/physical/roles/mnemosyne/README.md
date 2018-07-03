mnemosyne
=========

Install mnemosyne, start and enable its sync server, and enable unit monitoring.

Variables:

* `mnemosyne_user`: Optional. The user which will run the sync server. If not
  specified, a default value will be used.
* `mnemosyne_user_home`: Optional. The user's home directory. If not specified,
  a default value will be used.
* `mnemosyne_sync_username`: Optional. Credentials that the sync server will
  require clients to present before allowing them to sync. If not specified, no
  authentication credentials will be set in the sync server.
* `mnemosyne_sync_password`: Same as for `mnemosyne_sync_username`, but
  `s/username/password/`.
