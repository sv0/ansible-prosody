Ansible Prosody
===============

[![CI](https://github.com/sv0/ansible-prosody/actions/workflows/ci.yml/badge.svg)](https://github.com/sv0/ansible-prosody/actions/workflows/ci.yml)

Install and configure [Prosody](http://prosody.im/) XMPP(Jabber) server.

Requirements
------------

- Debian 11 (Bullseye)
- Debian 12 (Bookworm)
- Ubuntu 18.04

Default Variables
-----------------

Directory where TLS certificate could be found.
I use ACME client [dehydrated](https://dehydrated.io),
so all otained certificates are in `/var/lib/dehydrated/certs`

```yaml
prosody_certificate_dir: "/var/lib/dehydrated/certs"
```

see `defaults/main.yml` for more details.

Dependencies
------------

Download
--------

Download latest release with `ansible-galaxy`

```shell
    ansible-galaxy install sv0.prosody
```

Playbook
--------

```yaml
    - hosts: servers
      roles:
        - sv0.prosody
      vars:
        prosody_vhost: example.com
```

Tests
-----

Run local tests with

```shell
    molecule test
```

Requires Molecule and Docker to be installed on devel host.

License
-------

MIT

Author Information
------------------

[Slavik Svyrydiuk](https://slavik.svyrydiuk.eu/about.html)

Usefull links
-------------

- [Modern XMPP Server](https://docs.trueelena.org/self_hosting/modern_xmpp_server/index.html)
- [XMPP Compliance Tester](https://compliance.conversations.im)
- [This page tests the trickle ICE functionality in a WebRTC implementation](https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/)
