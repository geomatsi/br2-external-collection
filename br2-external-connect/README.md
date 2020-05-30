# Buildroot external layer: connect

## Overview

Simple Buildroot external layer for experimenting with Connman/oFono stack.

## Get sources

Get external layers:
```bash
$ git https://github.com/geomatsi/br2-external-collection.git
```

Get Buildroot release branch:
```bash
$ git clone git://git.buildroot.net/buildroot buildroot-release
$ cd buildroot-release
$ git checkout -b v2020.02.1 2020.02.1
```

## Select configuration

Timelapse server on Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_orangepi_zero_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instruction and write image to SDcard. Before booting device,
mount SDcard and edit the following files:
* `var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access
* `var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

## Links
* [ConnMan API documentation](https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc)
* [Debian ConnMan manpages](https://manpages.debian.org/testing/connman)
* [ArchLinux ConnMan tutorial](https://wiki.archlinux.org/index.php/ConnMan)
* [AGL ConnMan tutorial](https://wiki.automotivelinux.org/connman)
* [Tizen ConnMan tutorial](https://wiki.tizen.org/IVI/ConnMan_Tips_&_Tricks)
