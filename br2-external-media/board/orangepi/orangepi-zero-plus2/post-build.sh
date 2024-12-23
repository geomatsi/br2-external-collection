#!/bin/sh

PARTUUID="$($HOST_DIR/bin/uuidgen)"

install -d "$TARGET_DIR/boot/extlinux/"

sed -e "s/%PARTUUID%/$PARTUUID/g" \
	"$BR2_EXTERNAL_MEDIA_PATH/board/orangepi/orangepi-zero-plus2/extlinux.conf" > "$TARGET_DIR/boot/extlinux/extlinux.conf"

sed "s/%PARTUUID%/$PARTUUID/g" "board/orangepi/common/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"
