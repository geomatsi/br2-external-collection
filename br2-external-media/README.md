# br2-external-media

## Preliminary notes

Tested using the following environment:
* Buildroot baseline b98d283f86b2 (mid Dec 2024)
* Bootlin toolchain armv7-eabihf--glibc--bleeding-edge-2024.05-1.tar.xz

## Configure and build

```bash
$ make BR2_EXTERNAL=/path/to/br2-external-media orangepi_pc_plus_defconfig
$ make
```

