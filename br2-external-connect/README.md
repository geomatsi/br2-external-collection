# br2-external-connect

## Overview

External layer for experimenting with Linux Connman stack.

Major purposes:
* experiment with connman/ofono/neard stack
* clean up connman startup and provisioning procedures: make them work seamlessly out of the box

Supported board configurations:

* switching between Ethernet and WiFi on Orange Pi Zero board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_orangepi_zero_defconfig
```
* WiFi and USB gadget tethering on Raspberry Pi Zero W board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_rpi0w_gadget_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero board with `connect_orangepi_zero_defconfig` image:
* `/var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

For Raspberry Zero W board with `connect_rpi0w_gadget_defconfig` image:
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

## TODO

### Gadget tethering

For some reason gadget is not enabled by default on connman startup. So gadget technology
in connman has to be enabled first. This can be done using the following command:

```bash
$ connmanctl enable gadget
```

Obviously there should be some configuration switch to enable gadget by default. However so far I have not yet figured out which one. As a result, gadget image is not yet completely autonomous at the moment.

## Links
* [ConnMan API documentation](https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc)
* [Debian ConnMan manpages](https://manpages.debian.org/testing/connman)
* [ArchLinux ConnMan tutorial](https://wiki.archlinux.org/index.php/ConnMan)
* [AGL ConnMan tutorial](https://wiki.automotivelinux.org/connman)
* [Tizen ConnMan tutorial](https://wiki.tizen.org/IVI/ConnMan_Tips_&_Tricks)
