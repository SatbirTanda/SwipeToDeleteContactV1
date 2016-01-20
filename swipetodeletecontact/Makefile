ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:7
export SDKVERSION  = 7

export THEOS=/usr/local/theos


THEOS_BUILD_DIR = Packages

include $(THEOS)/makefiles/common.mk



BUNDLE_NAME = SwipeToDeleteContact
SwipeToDeleteContact_CFLAGS = -fno-objc-arc
SwipeToDeleteContact_FILES = SwipeToDeleteContactListController.m
SwipeToDeleteContact_INSTALL_PATH = /Library/PreferenceBundles
SwipeToDeleteContact_FRAMEWORKS = Foundation UIKit
SwipeToDeleteContact_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SwipeToDeleteContact.plist$(ECHO_END)
