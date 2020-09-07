# br2-external-usbcam

## Overview

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

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.

For Orange Pi Zero board with `timelapse_orangepi_zero_defconfig` image:
* Edit `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access

For Orange Pi Zero Plus2 board with `apcam_orangepi_zero_plus2_defconfig` image everything is up and running right out of the box:
* WiFi AP: SSID apcam, PSK topsecret
* AP IPv4 address: 192.168.100.1
* Note that Orange Pi Zero Plus2 does not have USB on board, so expansion board should be attached

## Stream and capture

Lets assume that device is up and running and a.b.c.d is its IP address.

### View stream

To view a single JPEG just point your web brower to the following URL:
* `http://a.b.c.d:8080/?action=snapshot`

To view a stream use another URL:
* `http://a.b.c.d:8080/?action=stream_0`

### Timelapse slideshow

Collect JPEG snapshots once a second:

```bash
$ for i in `seq 1 60`; do wget http://a.b.c.d:8080/\?action\=snapshot -q -O test$i.jpg; sleep 1;  done
```
Create a video slideshow from images using specified framerate:

```bash
$ ffmpeg -framerate 10 -pattern_type glob -i '*.jpg' slideshow.mp4
```
