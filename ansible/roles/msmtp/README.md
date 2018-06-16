msmtp
=====

Install and optionally configure msmtp for sending emails.

This role creates a group named `ichi-machines`, and users in this group are
authorized to send emails. msmtp isn't configured to send emails itself.
Instead, it logs into a third party service, and asks that service to send
emails on it's behalf. Send emails sparingly. An easy way to send an email is
as follows:

```bash
msmtp -a default addressee@example.com <<EOF
Subject: Test email

Sent by $(whoami) on $(date).
EOF
```

Variables:

* `msmtprc_password`: Optional. The password used by msmtp when logging into the
  service that actually sends emails. The msmtp configuration file is installed
  when this variable is provided.
