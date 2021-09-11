################################################################################
#
# cri-tools
#
################################################################################

CRI_TOOLS_VERSION = v1.21.0
CRI_TOOLS_SITE = $(call github,kubernetes-sigs,cri-tools,$(CRI_TOOLS_VERSION))

CRI_TOOLS_LICENSE = Apache-2.0
CRI_TOOLS_LICENSE_FILES = LICENSE

#CRI_TOOLS_TAGS =

CRI_TOOLS_BUILD_TARGETS = cmd/crictl
CRI_TOOLS_INSTALL_BINS = crictl

define CRI_TOOLS_INSTALL_MISC
	$(INSTALL) -m 0644 -D $(BR2_EXTERNAL_SYSTEM_PATH)/package/cri-tools/misc/crictl.yaml \
		$(TARGET_DIR)/etc/crictl.yaml
endef

CRI_TOOLS_POST_INSTALL_TARGET_HOOKS += CRI_TOOLS_INSTALL_MISC

$(eval $(golang-package))
