# br2-external-system

## Overview

External layer for experiments with various Linux system features.

Major purposes:
* experiments with docker, cri-o, podman
* experiments with remoteproc/rpmsg kernel frameworks

Supported configurations:

* Running docker on Orange Pi Zero Plus2 board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system docker_orangepi_zero_plus2_defconfig
```

* Running docker on Orange Pi PC Plus board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system docker_orangepi_pc_plus_defconfig
```

* Running CRI-O on Orange Pi PC Plus board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system crio_orangepi_pc_plus_defconfig
```

* Running podman on Orange Pi PC Plus board
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system podman_orangepi_pc_plus_defconfig
```

* Experiments with Cortex-M4 core on Udoo Neo board with iMX6SoloX CPU using Linux remoteproc/rpmsg subsystem
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system rproc_mx6sx_udoo_neo_defconfig
```

* Experiments with Cortex-M4 core on stm32mp157c-dk2 board using Linux remoteproc/rpmsg subsystem
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system rproc_stm32mp157c_dk2_defconfig
```

* Experiments with non-trusted stm32mp157c-dk2 config: U-Boot SPL w/o TF-A
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-system stm32mp157c_dk2_nontrusted_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instructions and write image to SDcard. Before booting device, mount SDcard and edit several files to make sure that WiFi connects on boot.
Edit `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access.

# HOWTOs

## Docker on Orange Pi boards

```bash
$ docker pull busybox
$ docker run -it busybox sh
```

## CRI-O on Orange Pi PC Plus

TODO:
- enable IPv6 networking in both kernel and iptables
- setup crio-wipe and crio-shutdown services

Basic example:

```bash
$ crictl pull busybox
Image is up to date for docker.io/library/busybox@sha256:2bb4c4428052c54b1f45f9a56ab230eed60183b03044f21b623a2988b28fd819

$ crictl images
IMAGE                       TAG                 IMAGE ID            SIZE
docker.io/library/busybox   latest              97d26c9193b2f       1.19MB

$ cd /opt/examples

# create pod
$ crictl runp pod_sandbox.json
8fd91f17266b2fe283576493294c8bc56ea125d842511eee7373d3b27305a215

# create container
$ crictl create 8fd91f17266b2 container_busybox.json pod_sandbox.json
bf85f83f2610c2d1b345239eff70c2cfff7fd9db97d32769c01b2d5b0800bcdd

# start container
$ crictl start bf85f83f2610c

# run shell inside container
$ crictl exec -it bf85f83f2610c /bin/sh
```

## Podman on Orange Pi PC Plus

Run basic interactive example:

```bash
$ podman pull docker.io/library/alpine
$ podman run -it -v /opt/Arrival:/opt docker.io/library/alpine
```

Run basic detached example:
```bash
$ podman pull docker.io/library/httpd
$ podman run -dt -p 8080:80/tcp docker.io/library/httpd
$ curl localhost:8080
<html><body><h1>It works!</h1></body></html>
```

Run Kubernetes pods with Podman play kube using attached [test.yaml](https://github.com/geomatsi/br2-external-collection/files/8566115/test.yaml.txt):
```
$ podman play kube test.yaml 
```

Stop and remove pod and its containers:
```bash
$ podman pod rm mypod -f
```

## Running firmware on Cortex-M4 cores

### Udoo Neo: i.MX6SoloX CPU

TODO

### stm32mp157c-dk2 board

TODO
