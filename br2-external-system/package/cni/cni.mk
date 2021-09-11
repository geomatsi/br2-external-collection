################################################################################
#
# cni
#
################################################################################

CNI_VERSION = v1.0.1
CNI_SITE = $(call github,containernetworking,cni,$(CNI_VERSION))
CNI_LICENSE = Apache-2.0
CNI_LICENSE_FILES = LICENSE

CNI_GO_ENV = GOPROXY=proxy.golang.org

define CNI_DOWNLOAD_VENDOR_PKGS
	cd $(@D); $(HOST_GO_TARGET_ENV) $(CNI_GO_ENV) $(GO_BIN) mod vendor
endef

CNI_PRE_BUILD_HOOKS += CNI_DOWNLOAD_VENDOR_PKGS

CNI_BUILD_TARGETS = cnitool
CNI_INSTALL_BINS = cnitool

$(eval $(golang-package))
