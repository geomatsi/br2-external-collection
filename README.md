# Collection of Buildroot external layers

## Summary

Collection of Buildroot BR2_EXTERNAL examples:

* br2-external-adsb
* br2-external-bluetooth
* br2-external-connect
* br2-external-usbcam

## Get sources

Check out source tree:
```bash
$ git https://github.com/geomatsi/br2-external-collection.git
```

Get Buildroot release branch:
```bash
$ git clone git://git.buildroot.net/buildroot buildroot-release
$ cd buildroot-release
$ git checkout -b v2020.02.3 2020.02.3
```

## br2-external-adsb

### Overview

External layer for ADS-B capture using _dump1090_ and _RTL-SDR dongle_ and simple remote access to captured data using Telegram bot.

Major purposes:
* integrate Golang application into Buildroot

Supported board configurations:
* ADSB Bot on Orange Pi Zero
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-adsb adsb_orangepi_zero_defconfig
```

### Build and flash image

```bash
$ time make
```

Follow Buildroot instruction and write image to SDcard. Before booting device, mount SDcard and edit the following files:
* `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access
* `/etc/openvpn/client.conf` and `/etc/openvpn/pass` to setup VPN connection for Telegram Bot
* `/etc/adsb/adsb_bot.conf` to setup authentication token for Telegram Bot

### ADS-B

Lets assume that device is up and running and a.b.c.d is its IP address.

#### View ADS-B map

To view a ADS-B map provided by dump1090 service just point your web brower to the following URL:
* `http://a.b.c.d:8080`

#### Telegram Bot

Telegram Bot supports the following simple commands:
* \toggle - enable/disable ADS-B updates
* \list - show current active ADS-B records

### Links
* [SBS-1 base station protocol](http://woodair.net/sbs/article/barebones42_socket_data.htm)
* [dump1090: ADS-B decoder designed for RTL SDR devices](https://github.com/MalcolmRobb/dump1090)
* [Go package for parsing ADS-B messages from SBS-1 protocol](https://pkg.go.dev/github.com/skypies/adsb)

## br2-external-bluetooth

### Overview

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

### Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to customize WiFi and Bluetooth settings:
* `/var/lib/connman/wifi_test1.config`: edit to configure AP name and password for wireless access
* `/var/lib/bluetooth/XX:XX:XX:XX:XX:XX`:rename directory to MAC address of rpi0w board under test

### Access rpi0w serial console using Bluetooth rfcomm

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

## br2-external-connect

### Overview

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

### Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero board with `connect_orangepi_zero_defconfig` image:
* `/var/lib/connman/eth_test1.config` to configure static IPv4 config or DHCP for wired access
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

For Raspberry Zero W board with `connect_rpi0w_gadget_defconfig` image:
* `/var/lib/connman/wifi_test1.config` to configure AP name and password for wireless access

### TODO

#### Gadget tethering

For some reason gadget is not enabled by default on connman startup. So gadget technology
in connman has to be enabled first. This can be done using the following command:

```bash
$ connmanctl enable gadget
```

Obviously there should be some configuration switch to enable gadget by default. However so far I have not yet figured out which one. As a result, gadget image is not yet completely autonomous at the moment.

### Links
* [ConnMan API documentation](https://git.kernel.org/pub/scm/network/connman/connman.git/tree/doc)
* [Debian ConnMan manpages](https://manpages.debian.org/testing/connman)
* [ArchLinux ConnMan tutorial](https://wiki.archlinux.org/index.php/ConnMan)
* [AGL ConnMan tutorial](https://wiki.automotivelinux.org/connman)
* [Tizen ConnMan tutorial](https://wiki.tizen.org/IVI/ConnMan_Tips_&_Tricks)

## br2-external-usbcam

### Overview

External layer for experiments with various Linux video capture software.

Major purposes:
* experiment with hotplug devices configurations in systemd
* experiment with Linux video capture software

Supported configurations:

* timelapse server on Orange Pi Zero board: WiFi STA mode
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-usbcam timelapse_orangepi_zero_defconfig
```

* timelapse server on Orange Pi Zero Plus2 board: WiFi AP mode
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-usbcam apcam_orangepi_zero_plus2_defconfig
```

### Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero board with `timelapse_orangepi_zero_defconfig` image:
* `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access

For Orange Pi Zero board with `apcam_orangepi_zero_plus2_defconfig` image everything is up and running right out of the box:
* WiFi AP: SSID apcam, PSK topsecret
* AP IPv4 address: 192.168.100.1
* Note that Orange Pi Zero Plus2 does not have USB on board, so expansion board should be attached

### Stream and capture

Lets assume that device is up and running and a.b.c.d is its IP address.

#### View stream

To view a single JPEG just point your web brower to the following URL:
* `http://a.b.c.d:8080/?action=snapshot`

To view a stream use another URL:
* `http://a.b.c.d:8080/?action=stream_0`

#### Timelapse slideshow

Collect JPEG snapshots once a second:

```bash
$ for i in `seq 1 60`; do wget http://a.b.c.d:8080/\?action\=snapshot -q -O test$i.jpg; sleep 1;  done
```
Create a video slideshow from images using specified framerate:

```bash
$ ffmpeg -framerate 10 -pattern_type glob -i '*.jpg' slideshow.mp4
```
