# Collection of Buildroot external layers

## Summary

Collection of Buildroot BR2_EXTERNAL examples:

* [br2-external-adsb](br2-external-adsb)
* [br2-external-bluetooth](br2-external-bluetooth)
* [br2-external-connect](br2-external-connect)
* [br2-external-system](br2-external-system)
* [br2-external-usbcam](br2-external-usbcam)

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

## Prepare selected configuration

Select layer and configuration:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-<layer_name> <config_name>_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions for the selected board and write image to SDcard.
