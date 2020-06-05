#!/bin/sh
BOARD_DIR="$(dirname $0)"

install -m 0644 -D $BOARD_DIR/config.txt $BINARIES_DIR/rpi-firmware/config.txt
