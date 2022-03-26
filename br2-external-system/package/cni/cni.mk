################################################################################
#
# cni
#
################################################################################

CNI_VERSION = v1.0.1
CNI_SITE = $(call github,containernetworking,cni,$(CNI_VERSION))
CNI_LICENSE = Apache-2.0
CNI_LICENSE_FILES = LICENSE

CNI_BUILD_TARGETS = cnitool
CNI_INSTALL_BINS = cnitool

$(eval $(golang-package))
