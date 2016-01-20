ARCHS = armv7 armv7s arm64

export THEOS=/usr/local/theos
#include theos/makefiles/common.mk


export THEOS_DEVICE_IP = ip6

THEOS_BUILD_DIR = Packages

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SwipeToDeleteContact
SwipeToDeleteContact_FILES = Tweak.xm
SwipeToDeleteContact_FRAMEWORKS = UIKit ContactsUI Contacts
SwipeToDeleteContact_CFLAGS = -Wno-error



include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"
	
SUBPROJECTS += swipetodeletecontact
include $(THEOS_MAKE_PATH)/aggregate.mk
