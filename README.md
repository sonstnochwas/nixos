# NixOS

> **WARNING:** This is the documentation of my personal setup and is therefore
aimed to work on **my** machines (which it now and then does). Please be aware,
that this might not work on your machine!

> **NOTE:** I might switch to unstable - at least for private use:
[nixos-unstable-small](https://channels.nixos.org/?prefix=nixos-unstable-small/)

## Documentation

Detailed installation instructions:
[official NixOS documentation](https://nixos.org/manual/nixos/stable)

Supporting resources:
- [NixOS Wiki](https://nixos.wiki/)
- [Awesomwe Nix](https://nix-community.github.io/awesome-nix/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [NixOS Package Search](https://search.nixos.org/packages)
- [NixOS Options Search](https://search.nixos.org/options)
- [NixOS & LUKS guide](https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134#file-nixos-md)
- [nixos-generators - one config, multiple formats](https://github.com/nix-community/nixos-generators)
- [nix.dev](https://nix.dev)
- [NixOS Configuration Collection](https://nixos.wiki/wiki/Configuration_Collection)
- [nixos-up](https://github.com/samuela/nixos-up)

## Pre-install

### Create installation media

Download minimal ISO [here](https://channels.nixos.org/nixos-21.11/latest-nixos-minimal-x86_64-linux.iso)
and write to thumb drive (recommendation: [Ventoy](https://github.com/ventoy/Ventoy)).

### Set up wifi (w/o Network Manager)

Wifi interface name:
```bash
$ ip -br add
# or beautiful:
$ ip -brief -color address
```

Start `wpa_supplicant`:
```bash
$ sudo systemctl start wpa_supplicant
```

Run `wpa_cli` to configure the wifi:
```bash
$ wpa_cli -i YourWifiInterfaceName
> add_network
0
> set_network 0 ssid "YourHomeNetwork"
OK
> set_network 0 psk "YourPassword"
OK
> set_network 0 key_mgmt WPA-PSK
OK
> enable_network 0
OK
... some more output ...
> quit
```

## Installation

The installation is guided by the script `install.sh` to various extends.

```bash
# download install script
$ curl -L https://tinyurl.com/mynixos/install.sh --output install.sh
# make it executable
$ chmod u+x install.sh
```

> Detailed instructions to follow ... one day ... hopefully not too far away.

## ToDo

### List of services I need to try

- services.confluence
- services.dockerRegistry
- services.elasticsearch
- services.github-runner
- services.gitlab
- services.gocd-agent
- services.grafana
- services.haproxy
- services.jenkins
- services.jira
- services.journalbeat
- services.kibana
- services.kubernetes
- services.logstash
- services.loki
- services.minecraft-server
- services.nextcloud
- services.nginx
- services.nomad
- services.openldap
- services.postgresql
- services.prometheus
- services.rabbitmq
- services.redis
- services.redshift
- services.thermald
- services.thinkfan
- services.tlp
- services.vault
- services.vaultwarden
- services.xserver.desktopManager.wallpaper.mode
