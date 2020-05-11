################################################################################
#
# adsb-bot
#
################################################################################

ADSB_BOT_VERSION = 3a924b237ecd3219a277520a85d052194cfb2724
ADSB_BOT_SITE = $(call github,geomatsi,go-tests,$(ADSB_BOT_VERSION))

ADSB_BOT_SRC_SUBDIR = github.com/geomatsi/adsb-bot
ADSB_BOT_GO_ENV = GO111MODULE=on

define ADSB_BOT_TRIM_SOURCE
	rm -rf $(@D)/tests $(@D)/tour
	mv $(@D)/adsb-bot/* $(@D)
	rm -rf $(@D)/adsb-bot
endef

define ADSB_BOT_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/adsb
	$(INSTALL) -D -m 0644 $(@D)/data/bot.json $(TARGET_DIR)/etc/adsb/adsb_bot.conf
endef

ADSB_BOT_POST_EXTRACT_HOOKS += ADSB_BOT_TRIM_SOURCE
ADSB_BOT_POST_INSTALL_TARGET_HOOKS += ADSB_BOT_INSTALL_CONFIG_FILES

define ADSB_BOT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(ADSB_BOT_PKGDIR)/adsb_bot.service  $(TARGET_DIR)/usr/lib/systemd/system/adsb_bot.service
endef

$(eval $(golang-package))
