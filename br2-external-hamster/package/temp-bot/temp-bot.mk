################################################################################
#
# temp-bot
#
################################################################################

TEMP_BOT_VERSION = 0.2
TEMP_BOT_SOURCE = temp-bot-v$(TEMP_BOT_VERSION).tar.gz
TEMP_BOT_SITE = https://github.com/geomatsi/go-tests/releases/download/go-tests--temp-bot-v$(TEMP_BOT_VERSION)

TEMP_BOT_GOMOD = temp-bot

define TEMP_BOT_INSTALL_CONFIG_FILES
	$(INSTALL) -D -m 0644 $(@D)/data/bot.json $(TARGET_DIR)/etc/bot.cfg
endef

TEMP_BOT_POST_INSTALL_TARGET_HOOKS += TEMP_BOT_INSTALL_CONFIG_FILES

define TEMP_BOT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(TEMP_BOT_PKGDIR)/temp_bot.service  $(TARGET_DIR)/usr/lib/systemd/system/temp_bot.service
endef

$(eval $(golang-package))
