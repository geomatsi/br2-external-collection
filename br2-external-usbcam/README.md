# Buildroot external layer: video

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

## Build images

```bash
$ time make
```
