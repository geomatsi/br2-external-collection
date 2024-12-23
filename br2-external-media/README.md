# br2-external-media

## Preliminary notes

Tested using the following environment:
* Buildroot baseline b98d283f86b2 (mid Dec 2024)
* Bootlin toolchains:
  - armv7-eabihf--glibc--bleeding-edge-2024.05-1.tar.xz
  - aarch64--glibc--bleeding-edge-2024.05-1.tar.xz

## Configure and build

```bash
$ make clean
$ make BR2_EXTERNAL=/path/to/br2-external-media orangepi_pc_plus_defconfig
$ make
```

```bash
$ make clean
$ make BR2_EXTERNAL=/path/to/br2-external-media orangepi_zero_plus2_defconfig
$ make
```

## Tests

### Simple graphics using KMS

```bash
$ kmscube
```

### Weston desktop

Start Weston compositor:

```bash
mkdir /tmp/xdg
export XDG_RUNTIME_DIR=/tmp/xdg
weston -S wayland-0 --shell desktop --idle-time=0 --continue-without-input &
```

Start simple clients

```bash
$ weston-flower
$ weston-simple-egl
```

### Orange Pi ov5640 5MP camera

Check media devices

```bash
$ v4l2-ctl --list-devices
sun6i-csi-capture (platform:1cb0000.camera):
        /dev/video0
        /dev/media0
```

Check topology

```bash
$ media-ctl -d 0 -p
Media controller API version 6.12.3

Media device information
------------------------
driver          sun6i-csi
model           Allwinner A31 CSI Device
serial
bus info        platform:1cb0000.camera
hw revision     0x0
driver version  6.12.3

Device topology
- entity 1: sun6i-csi-bridge (2 pads, 2 links, 0 routes)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
        pad0: SINK
                [stream:0 fmt:unknown/0x0]
                <- "ov5640 0-003c":0 [ENABLED]
        pad1: SOURCE,MUST_CONNECT
                [stream:0 fmt:unknown/0x0]
                -> "sun6i-csi-capture":0 [ENABLED,IMMUTABLE]

- entity 4: sun6i-csi-capture (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video0
        pad0: SINK,MUST_CONNECT
                <- "sun6i-csi-bridge":1 [ENABLED,IMMUTABLE]

- entity 10: ov5640 0-003c (1 pad, 1 link, 0 routes)
             type V4L2 subdev subtype Sensor flags 0
             device node name /dev/v4l-subdev1
        pad0: SOURCE
                [stream:0 fmt:UYVY8_2X8/640x480@1/30 field:none colorspace:srgb xfer:srgb ycbcr:601 quantization:full-range
                 crop.bounds:(0,0)/2624x1964
                 crop:(0,4)/2624x1944]
                -> "sun6i-csi-bridge":0 [ENABLED]
```

Configure camera format and frame size

```
$ media-ctl -v -d 0 --set-v4l2 '"ov5640 0-003c":0[fmt:YUYV8_2X8/640x480]'
$ v4l2-ctl -d 0 --set-fmt-video=width=640,height=480,pixelformat=YUYV
```

Test camera using Weston sample application

```bash
$ weston-simple-dmabuf-v4l /dev/video0
```

Test camera using GStreamer and Weston

```bash
$ gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw,width=640,height=480,format=YUY2 ! waylandsink
```
