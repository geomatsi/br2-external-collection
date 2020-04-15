# Buildroot external layer: usbcam 

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

## Select server configuration

Timelapse server on Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-usbcam timelapse_orangepi_zero_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instruction and write image to SDcard. Before booting device,
mount SDcard and edit `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf`
to setup wireless access.

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
