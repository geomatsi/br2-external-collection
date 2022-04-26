################################################################################
#
# podman
#
################################################################################

PODMAN_VERSION = v4.0.2
PODMAN_SITE = $(call github,containers,podman,$(PODMAN_VERSION))

PODMAN_LICENSE = Apache-2.0
PODMAN_LICENSE_FILES = LICENSE

PODMAN_DEPENDENCIES = btrfs-progs libgpgme lvm2 libseccomp

PODMAN_GOMOD = .
#PODMAN_TAGS = exclude_graphdriver_btrfs exclude_graphdriver_devicemapper
PODMAN_TAGS = seccomp

PODMAN_BUILD_TARGETS = cmd/podman cmd/rootlessport
PODMAN_INSTALL_BINS = podman rootlessport

define PODMAN_INSTALL_MISC
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/containers

	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/podman/misc/policy.json \
		$(TARGET_DIR)/etc/containers/policy.json
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/podman/misc/registries.conf \
		$(TARGET_DIR)/etc/containers/registries.conf
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/podman/misc/containers.conf \
		$(TARGET_DIR)/etc/containers/containers.conf
endef

PODMAN_POST_INSTALL_TARGET_HOOKS += PODMAN_INSTALL_MISC

$(eval $(golang-package))
