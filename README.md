Ansible Prosody
===============
[![CI](https://github.com/sv0/ansible-prosody/workflows/CI/badge.svg?event=push)](https://github.com/sv0/ansible-prosody/actions?query=workflow%3ACI)

Install and configure [Prosody](http://prosody.im/) XMPP(Jabber) server.

## Requirements

  - Debian 11 (Bullseye)
  - Debian 12 (Bookworm)
  - Ubuntu 18.04

## Default Variables

see `defaults/main.yml`


## Dependencies


## Download

Download latest release with `ansible-galaxy`

    ansible-galaxy install sv0.prosody


## Playbook

    - hosts: servers
      roles:
        - sv0.prosody
      vars:
        prosody_virtual_hosts:
          - name: example.net
            key: |
              -----BEGIN PRIVATE KEY-----
                ...
              -----END PRIVATE KEY-----
            cert: |
                -----BEGIN CERTIFICATE-----
                  ...
                -----END CERTIFICATE-----
          - name: svyrydiuk.eu
            admins: ["admin@svyrydiuk.eu"]


## Tests

Run local tests with

    molecule test

Requires Molecule and Docker to be installed on devel host.

## License

GPL

## Author Information

[Slavik Svyrydiuk](https://slavik.svyrydiuk.eu/about.html)
