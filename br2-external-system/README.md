# br2-external-system

## Overview

External layer for experiments with various Linux system features.

Major purposes:
* experiments with read-only rootfs and initramfs
* experiments with GPT partition tables
* experiments with docker
* experiments with A/B system image updates
* experiments with remoteproc/rpmsg kernel frameworks

Supported configurations:

* Running docker on Orange Pi Zero Plus2 board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system docker_orangepi_zero_plus2_defconfig
```

* Experiments with Cortex-M4 core on Udoo Neo board with iMX6SoloX CPU using Linux remoteproc/rpmsg subsystem
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system rproc_mx6sx_udoo_neo_defconfig
```

* Experiments with Cortex-M4 core on Engicam i.Core MX8X board with i.MX8QXP CPU using Linux remoteproc/rpmsg subsystem
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system rproc_mx8qx_icore_defconfig
```

* Experiments with Cortex-M4 core on stm32mp157c-dk2 board using Linux remoteproc/rpmsg subsystem
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system rproc_stm32mp157c_dk2_defconfig
```

Note: remoteproc/rpmsg configs works with Buildroot starting from 2020.11 release.

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.
Edit `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access.

# HOWTOs

## Docker on Orange Pi Zero Plus2

```bash
$ docker pull busybox
$ docker run -it busybox sh
```

## Running firmware on Cortex-M4 cores

### Udoo Neo: i.MX6SoloX CPU

TODO

### i.Core MX8X: i.MX8QXP CPU

#### Flash Buildroot image using UUU

Use boot switches to configure board boot over USB. Then write Buildroot image to the on-board eMMC using UUU tool:

```bash
$ cd output/images
$ sudo uuu sdps: boot -f imx8-boot-sd.bin
$ sudo uuu fb: ucmd setenv fastboot_dev mmc
$ sudo uuu fb: ucmd setenv mmcdev 0
$ sudo uuu fb: ucmd mmc dev 0
$ sudo uuu fb: flash -raw2sparse all sdcard.img
```

#### Run Cortex-M4 firmware

TODO

### stm32mp157c-dk2 board

TODO
