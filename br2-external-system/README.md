# br2-external-system

## Overview

External layer for experiments with various Linux system features.

Major purposes:
* experiments with read-only rootfs and initramfs
* experiments with GPT partition tables
* experiments with docker
* experiments with A/B system image updates

Supported configurations:

* Running docker on Orange Pi Zero Plus2 board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system docker_orangepi_zero_plus2_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero Plus2 board with `docker_orangepi_zero_plus2_defconfig`:
* Edit `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access

## Using docker on Orange Pi Zero Plus2

```bash
$ docker pull busybox
$ docker run -it busybox sh
```
