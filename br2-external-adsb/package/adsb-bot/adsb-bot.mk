################################################################################
#
# adsb-bot
#
################################################################################

ADSB_BOT_VERSION = v0.1
ADSB_BOT_SOURCE = adsb-bot-$(ADSB_BOT_VERSION).tar.gz
ADSB_BOT_SITE = https://github.com/geomatsi/go-tests/releases/download/go-tests--adsb-bot-$(ADSB_BOT_VERSION)

ADSB_BOT_GO_ENV = GOPROXY=proxy.golang.org
ADSB_BOT_GOMOD = adsb-bot

define ADSB_BOT_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/adsb
	$(INSTALL) -D -m 0644 $(@D)/data/bot.json $(TARGET_DIR)/etc/adsb/adsb_bot.conf
endef

ADSB_BOT_POST_INSTALL_TARGET_HOOKS += ADSB_BOT_INSTALL_CONFIG_FILES

define ADSB_BOT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(ADSB_BOT_PKGDIR)/adsb_bot.service  $(TARGET_DIR)/usr/lib/systemd/system/adsb_bot.service
endef

$(eval $(golang-package))
