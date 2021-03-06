# br2-external-adsb

## Overview

External layer for ADS-B capture using _dump1090_ and _RTL-SDR dongle_ and simple remote access to captured data using Telegram bot.

Major purposes:
* integrate Golang application into Buildroot

Supported board configurations:
* ADSB Bot on Orange Pi Zero
```bash
$ make BR2_EXTERNAL=/path/to/br2-external-adsb adsb_orangepi_zero_defconfig
```

## Build and flash image

```bash
$ time make
```

Follow Buildroot instruction and write image to SDcard. Before booting device, mount SDcard and edit the following files:
* `/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf` to setup wireless access
* `/etc/openvpn/client.conf` and `/etc/openvpn/pass` to setup VPN connection for Telegram Bot
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

## Links
* [SBS-1 base station protocol](http://woodair.net/sbs/article/barebones42_socket_data.htm)
* [dump1090: ADS-B decoder designed for RTL SDR devices](https://github.com/MalcolmRobb/dump1090)
* [Go package for parsing ADS-B messages from SBS-1 protocol](https://pkg.go.dev/github.com/skypies/adsb)
