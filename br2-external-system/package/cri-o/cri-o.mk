################################################################################
#
# cri-o
#
################################################################################

CRI_O_VERSION = v1.23.2
CRI_O_SITE = $(call github,cri-o,cri-o,$(CRI_O_VERSION))

CRI_O_LICENSE = Apache-2.0
CRI_O_LICENSE_FILES = LICENSE

CRI_O_DEPENDENCIES = btrfs-progs libgpgme lvm2

#CRI_O_TAGS = exclude_graphdriver_btrfs exclude_graphdriver_devicemapper

CRI_O_BUILD_TARGETS = cmd/crio-status cmd/crio
CRI_O_INSTALL_BINS = crio-status crio pinns

define CRI_O_BUILD_PINNS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
		STRIP="$(TARGET_STRIP)" \
		-C $(@D)/pinns
endef

CRI_O_POST_BUILD_HOOKS += CRI_O_BUILD_PINNS

define CRI_O_INSTALL_MISC
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/crio
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/default
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/containers

	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/crio \
		$(TARGET_DIR)/etc/default/crio
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/crio.conf \
		$(TARGET_DIR)/etc/crio/crio.conf
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/policy.json \
		$(TARGET_DIR)/etc/containers/policy.json
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/registries.conf \
		$(TARGET_DIR)/etc/containers/registries.conf
endef

CRI_O_POST_INSTALL_TARGET_HOOKS += CRI_O_INSTALL_MISC

define CRI_O_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/crio.service \
		$(TARGET_DIR)/etc/systemd/system/crio.service
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/crio-wipe.service \
		$(TARGET_DIR)/etc/systemd/system/crio-wipe.service
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-o/misc/crio-shutdown.service \
		$(TARGET_DIR)/etc/systemd/system/crio-shutdown.service
endef

$(eval $(golang-package))
