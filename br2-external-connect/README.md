# br2-external-connect

## Overview

External layer for experimenting with Linux Connman stack.

Major purposes:
* experiment with connman/ofono/wifi/bluez/neard stack
* clean up connman startup and provisioning procedures: make them work seamlessly out of the box

## Supported board configurations

### Buildroot configuration: connect_orangepi_zero_defconfig
Use connman/wpa_supplicant to switch between Ethernet and WiFi on Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_orangepi_zero_defconfig
```

### Buildroot configuration: connect_rpi0w_gadget_defconfig
Use connman/wpa_supplicant to implement USB gadget tethering on Raspberry Pi Zero W board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect connect_rpi0w_gadget_defconfig
```

### Buildroot configuration: gsm_stm32mp157c_dk2_defconfig
Use connman/ofono to switch between Ethernet and Cellular using SIM800L modem on STM32MP157C-DK2 board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-connect gsm_stm32mp157c_dk2_defconfig
```

#### Cellular connectivity using SIM800L modem
Hardware connections:

| Modem | Board | Comments |
|-|-|-|
| TX  | PE7 (USART7_RX) | pin 1 on CN14 connector |
| RX  | PE8 (USART7_TX) | pin 2 on CN14 connector |
| RST | PE1 | pin 3 on CN14 connector |

Note that modem SIM800L can not be powered from the board since neither 3v3 nor 5v0 are suitable for its proper operations.
Its operating voltage should be between 3v5 and 4v4. The simplest option is to power modem using a separate Li-Ion battery.

#### Buildroot version

Last tested buildroot baseline: 34cce93adb06608992023c44fa3245d1f1a3deb4.

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi or Ethernet connects on boot.

For Orange Pi Zero board with `connect_orangepi_zero_defconfig` image:
* `/var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

For Raspberry Zero W board with `connect_rpi0w_gadget_defconfig` image:
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

For STM32MP157C-DK2 board with `gsm_stm32mp157c_dk2_defconfig` image:
* `/var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access

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
