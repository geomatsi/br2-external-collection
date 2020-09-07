# br2-external-bluetooth

## Overview

External layer for experimenting with Linux BlueZ bluetooth software.

Major purposes:
* integrate BlueZ components into systemd to enable seamless Linux bluetooth bring-up on boot
* experiment with Linux CAN software

Supported board configurations:
* RFCOMM serial access to Raspberry Pi Zero W board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-bluetooth connect_rpi0w_rfcomm_defconfig
```
* TODO: ELM237 CAN logger using Raspberry Pi Zero W board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-bluetooth connect_rpi0w_can_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to customize WiFi and Bluetooth settings:
* `/var/lib/connman/wifi_test1.config`: edit to configure AP name and password for wireless access
* `/var/lib/bluetooth/XX:XX:XX:XX:XX:XX`:rename directory to MAC address of rpi0w board under test

## Access rpi0w serial console using Bluetooth rfcomm

Serial access to rpi0w board via Bluetooth rfcomm should be available right out of the box:
- bluetooth enablement is handled by systemd: see rfcomm and btattach services
- discovery and pairing is enabled by bluetooth configuration files:
  - see `/etc/bluetooth/main.conf` and `/var/lib/bluetooth/XX:XX:XX:XX:XX:XX/settings`

Execute the following steps on host:

* Configure bluetooth on host:
Use bluetoothctl tool to bring-up controller on host, then to scan and to pair with rpi0w:
```bash
$ sudo systemctl start bluetooth
$ bluetoothctl
[bluetooth]# power on
[bluetooth]# scan on
[bluetooth]# pair XX:XX:XX:XX:XX:XX
[bluetooth]# quit
```
* Configure rfcomm on host:
Setup rfcomm and connect to rpi0w after pairing is successfully completed:
```bash
$ sudo rfcomm bind 0 XX:XX:XX:XX:XX:XX
$ sudo minicom -D /dev/rfcomm0
```

Here replace XX:XX:XX:XX:XX:XX by bluetooth MAC address of rpi0w board under test.
