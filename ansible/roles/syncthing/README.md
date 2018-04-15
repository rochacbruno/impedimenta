syncthing
=========

When executed, this role will install [Syncthing](https://syncthing.net/) and
enable it on for the given users.

The `syncthing_usernames` variable is required.

Example playbook:

```yaml
- hosts: all
  roles:
    - name: syncthing
      vars:
        syncthing_usernames:
          - alice
          - bob
```
