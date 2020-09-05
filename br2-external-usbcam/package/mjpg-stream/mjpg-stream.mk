################################################################################
#
# mjpg-streamer
#
################################################################################

MJPG_STREAM_VERSION = 501f6362c5afddcfb41055f97ae484252c85c912
MJPG_STREAM_SITE = $(call github,jacksonliam,mjpg-streamer,$(MJPG_STREAM_VERSION))
MJPG_STREAM_SUBDIR = mjpg-streamer-experimental
MJPG_STREAM_LICENSE = GPL-2.0+
MJPG_STREAM_LICENSE_FILES = $(MJPG_STREAM_SUBDIR)/LICENSE
MJPG_STREAM_DEPENDENCIES = jpeg libv4l

MJPG_STREAM_CONF_OPTS += -DPLUGIN_INPUT_PTP2=OFF
MJPG_STREAM_CONF_OPTS += -DPLUGIN_INPUT_OPENCV=OFF
MJPG_STREAM_CONF_OPTS += -DPLUGIN_OUTPUT_ZMQSERVER=OFF
MJPG_STREAM_CONF_OPTS += -DPLUGIN_OUTPUT_VIEWER=OFF

$(eval $(cmake-package))
