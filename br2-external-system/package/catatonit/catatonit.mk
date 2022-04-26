################################################################################
#
# catatonit
#
################################################################################

CATATONIT_VERSION = v0.1.7
CATATONIT_SITE = $(call github,openSUSE,catatonit,$(CATATONIT_VERSION))

CATATONIT_LICENSE = GPL-3.0+
CATATONIT_LICENSE_FILES = COPYING

CATATONIT_AUTORECONF = YES

$(eval $(autotools-package))
