################################################################################
#
# crun
#
################################################################################

CRUN_VERSION = 1.4.3
CRUN_SITE = https://github.com/containers/crun/releases/download/$(CRUN_VERSION)
CRUN_LICENSE = GPL-2.0
CRUN_LICENSE_FILES = LICENSE

CRUN_DEPENDENCIES = yajl libseccomp

$(eval $(autotools-package))
