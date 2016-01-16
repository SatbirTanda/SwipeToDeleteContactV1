include theos/makefiles/common.mk

TWEAK_NAME = SwipeToDeleteContact
SwipeToDeleteContact_FILES = Tweak.xm
SwipeToDeleteContact_FRAMEWORKS = UIKit ContactsUI
SwipeToDeleteContact_CFLAGS = -Wno-error



include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
