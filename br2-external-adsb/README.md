# Buildroot external layer: adsb

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

## Select configuration

Timelapse server on Orange Pi Zero board:
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-adsb adsb_orangepi_zero_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instruction and write image to SDcard. Before booting device,
mount SDcard and edit the following files:
* `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access
* `/etc/openvpn/client.conf` and `/etc/openvpn/pass` to setup VPN client and enable Telegram Bot
* `/etc/adsb/adsb_bot.conf` to setup authentication token for Telegram Bot

## ADS-B

Lets assume that device is up and running and a.b.c.d is its IP address.

### View ADS-B map

To view a ADS-B map provided by dump1090 service just point your web brower to the following URL:
* `http://a.b.c.d:8080`

### Telegram Bot

Telegram Bot supports the following simple commands:
* \toggle - enable/disable ADS-B updates
* \list - show current active ADS-B records
