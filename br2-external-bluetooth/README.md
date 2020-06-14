# Buildroot external layer: connect

## Overview

Simple Buildroot external layer for experimenting with Bluetooth.

## Get sources

Get external layers:
```bash
$ git https://github.com/geomatsi/br2-external-collection.git
```

Get Buildroot release branch:
```bash
$ git clone git://git.buildroot.net/buildroot buildroot-release
$ cd buildroot-release
$ git checkout -b v2020.02.3 2020.02.3
```

## Select configuration

Bluetooth serial access to Raspberry Pi Zero W board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-bluetooth connect_rpi0w_rfcomm_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device,
mount SDcard and edit several files to make sure that WiFi connects on boot.

For Raspberry Zero W board:
* `var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

Note that for Raspberry Zero W this step is particularly important since selected DTS overlay
enables USB gadget but disables UART port.

## TODO

### Bluetooth autostart

Bluetooth is not yet wrapped into proper autonomous sequence of systemd unit
files and connman/bluez configuration files. For now this is a collection
of commands on both rpi0-w and host to establish rfcomm serial access
to rpi0-w board over bluetooth.

* Enable bluetooth on rpi0-w and setup rfcomm:
```bash
$ hciattach /dev/ttyAMA0 bcm43xx 921600 flow
$ rfkill unblock bluetooth
$ rfcomm watch /dev/rfcomm0 1 /sbin/agetty rfcomm0 115200 linux
```
* Use bluetoothctl tool to bring-up controllers on both host and rpi0w:
```bash
$ bluetoothctl power on
$ bluetoothctl discoverable on
```
* Use bluetoothctl tool on host to pair with rpi0w:
```bash
$ bluetoothctl scan on
$ bluetoothctl pair <peer MAC>
```
Note that for now you will have confirm pin on both host and rpi0w
* Setup rfcomm serial connection on host:
```bash
$ sudo rfcomm bind 0 <rpi0-w bt MAC address>
$ sudo minicom -D /dev/rfcomm0
```

## Links
* [ConnMan API documentation](https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc)
* [Debian ConnMan manpages](https://manpages.debian.org/testing/connman)
* [ArchLinux ConnMan tutorial](https://wiki.archlinux.org/index.php/ConnMan)
* [AGL ConnMan tutorial](https://wiki.automotivelinux.org/connman)
* [Tizen ConnMan tutorial](https://wiki.tizen.org/IVI/ConnMan_Tips_&_Tricks)
