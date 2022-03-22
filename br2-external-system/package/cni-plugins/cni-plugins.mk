################################################################################
#
# cni-plugins
#
################################################################################

CNI_PLUGINS_VERSION = v1.1.1
CNI_PLUGINS_SITE = $(call github,containernetworking,plugins,$(CNI_PLUGINS_VERSION))

CNI_PLUGINS_LICENSE = Apache-2.0
CNI_PLUGINS_LICENSE_FILES = LICENSE

CNI_PLUGINS_BUILD_TARGETS = \
	plugins/meta/bandwidth 		\
	plugins/meta/firewall 		\
	plugins/meta/portmap		\
	plugins/meta/sbr		\
	plugins/meta/tuning		\
	plugins/meta/vrf		\
	plugins/ipam/dhcp		\
	plugins/ipam/host-local		\
	plugins/ipam/static		\
	plugins/main/bridge		\
	plugins/main/host-device	\
	plugins/main/ipvlan		\
	plugins/main/loopback		\
	plugins/main/macvlan		\
	plugins/main/ptp		\
	plugins/main/vlan

define CNI_PLUGINS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/cni/net.d
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/cni

	cp -r $(@D)/bin $(TARGET_DIR)/usr/lib/cni/
	cp -r $(BR2_EXTERNAL_SYSTEM_PATH)/package/cni-plugins/conf/* $(TARGET_DIR)/etc/cni/net.d/
endef

$(eval $(golang-package))
