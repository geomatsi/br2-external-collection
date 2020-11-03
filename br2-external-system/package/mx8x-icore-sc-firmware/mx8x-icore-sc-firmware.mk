################################################################################
#
# mx8x-icore-sc-firmware
#
################################################################################

MX8X_ICORE_SC_FIRMWARE_VERSION = 0.1
MX8X_ICORE_SC_FIRMWARE_SITE = $(BR2_EXTERNAL_SYSTEM_PATH)/board/imx8/icore-mx8x/mx8x-icore-sc-firmware
MX8X_ICORE_SC_FIRMWARE_SITE_METHOD = local
MX8X_ICORE_SC_FIRMWARE_LICENSE = Proprietary
MX8X_ICORE_SC_FIRMWARE_REDISTRIBUTE = NO

define MX8X_ICORE_SC_FIRMWARE_INSTALL_TARGET_CMDS
	install -m 666 $(@D)/mx8qx-icore-scfw-tcm.bin ${BINARIES_DIR}/mx8qx-mek-scfw-tcm.bin
	
endef

$(eval $(generic-package))
