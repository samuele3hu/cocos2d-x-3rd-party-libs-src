# gafplayerlua

GAFPLAYERLUA_GITURL := https://github.com/samuele3hu/Cocos2dxGAFPlayer.git

$(TARBALLS)/gafplayerlua-git.tar.xz:
	$(call download_git,$(GAFPLAYERLUA_GITURL),release-gaf-4-lua)


.sum-gafplayerlua: gafplayerlua-git.tar.xz
	$(warning $@ not implemented)
	touch $@

gafplayerlua: gafplayerlua-git.tar.xz .sum-gafplayerlua
	$(UNPACK)
	$(MOVE)

ifdef HAVE_TIZEN
EX_ECFLAGS = -fPIC
endif

ifdef HAVE_MACOSX
CMAKE_DEFINE=MACOX
endif

ifdef HAVE_IOS
CMAKE_DEFINE=IOS
endif

ifdef HAVE_ANDROID
CMAKE_DEFINE=ANDROID
endif

ifndef HAVE_CROSS_COMPILE
ifdef HAVE_LINUX
CMAKE_DEFINE=LINUX
endif
endif

.gafplayerlua: gafplayerlua toolchain.cmake
	cd $</lua_bindings && $(HOSTVARS) CFLAGS="$(CFLAGS) $(EX_ECFLAGS)" ${CMAKE} -D${CMAKE_DEFINE}=1
	cd $</lua_bindings && $(MAKE) VERBOSE=1 install
	touch $@
