TARGET := iphone:16.5:14
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	PACKAGE_BUILDNAME := rootless
else
	PACKAGE_BUILDNAME := rootful
endif

TWEAK_NAME = foreverUnlocked

foreverUnlocked_FILES = Tweak.xm
foreverUnlocked_CFLAGS = -fobjc-arc -Iinclude

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/tweak.mk
