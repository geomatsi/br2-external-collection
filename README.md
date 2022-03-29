# Collection of Buildroot external layers

## Summary

Collection of Buildroot BR2_EXTERNAL examples:

* [br2-external-adsb](br2-external-adsb)
* [br2-external-bluetooth](br2-external-bluetooth)
* [br2-external-connect](br2-external-connect)
* [br2-external-system](br2-external-system)
* [br2-external-usbcam](br2-external-usbcam)

## Get sources

---
**NOTE**

All the examples have been tested on top of the following Buildroot baseline:
* branch: 2022.x
* commit: 96b346cb56ccf5ef52b29d367db5149d212c45df
---

Check out source tree:
```bash
$ git https://github.com/geomatsi/br2-external-collection.git
```

Get Buildroot 2022.x release branch:
```bash
$ git clone git://git.buildroot.net/buildroot buildroot-release
$ cd buildroot-release
$ git checkout -b rel-2022.02.x origin/2022.02.x
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
