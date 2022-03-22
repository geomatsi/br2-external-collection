################################################################################
#
# conmon
#
################################################################################

CONMON_VERSION = v2.1.0
CONMON_SITE = $(call github,containers,conmon,$(CONMON_VERSION))

CONMON_LICENSE = Apache-2.0
CONMON_LICENSE_FILES = LICENSE

define CONMON_BUILD_CMDS
	cd $(@D) && $(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)"
endef

define CONMON_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bin/conmon $(TARGET_DIR)/usr/bin/conmon
endef

$(eval $(generic-package))
