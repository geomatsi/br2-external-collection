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

Connman experiments with switching between Ethernet and WiFi on  Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_orangepi_zero_defconfig
```

Connman experiments with WiFi and USB gadget tethering on  Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_orangepi_zero_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device,
mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero board:
* `var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access
* `var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

For Raspberry Zero W board:
* `var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

Note that for Raspberry Zero W this step is particularly important since selected DTS overlay
enables USB gadget but disables UART port.

## TODO: Bluetooth

Next step is to split Bluetooth experiments into a separate configuration file.
For now this is a collection of commands on both rpi0-w and host to establish
rfcomm serial access to rpi0-w board over bluetooth.

* Enable bluetooth on rpi0-w and setup rfcomm:
```bash
$ hciattach /dev/ttyAMA0 bcm43xx 921600 flow
$ echo 1 >  /sys/class/rfkill/rfkill1/state
$ mknod -m 666 /dev/rfcomm0 c 216 0
$ rfcomm watch /dev/rfcomm0 1 /sbin/agetty rfcomm0 115200 linux
```
* Use bluetoothctl tool for pairing on both host and rpi0-w:
```bash
$ bluetoothctl discoverable on
$ bluetoothctl scan on
$ bluetoothctl pair <peer MAC>
```
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
