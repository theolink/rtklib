include $(TOPDIR)/rules.mk

PKG_NAME:=rtklib
PKG_VERSION:=2.4.3_b31
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=git://github.com/tomojitakasu/RTKLIB.git
PKG_SOURCE_VERSION:=1cec90a9ffa424908ad1a4ca3d52f33f9b94d1f7
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
#PKG_MIRROR_HASH:=edda6c29ba3d2f5401145a1497e88646fa0c13afc31ade7bdd982bd8e8081c6a
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_LICENSE:=BSD-2-Clause

#PKG_MAINTAINER:=Nuno Goncalves <nunojpg@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/rtklib/default
  SUBMENU:=RTKLIB Suite
  SECTION:=utils
  CATEGORY:=Utilities
  URL:=http://www.rtklib.com/
  DEPENDS:=+libpthread +librt
endef

#define Package/convbin
#$(call Package/rtklib/default)
#  TITLE:=RINEX Converter
#endef

#define Package/pos2kml
#$(call Package/rtklib/default)
#  TITLE:=Solution to KML converter
#endef

#define Package/rnx2rtkp
#$(call Package/rtklib/default)
#  TITLE:=Post-Processing Analysis
#endef

define Package/rtkrcv
$(call Package/rtklib/default)
  TITLE:=Real-Time Positioning
endef

define Package/str2str
$(call Package/rtklib/default)
  TITLE:=Communication Server
endef

define Build/Compile
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./* $(PKG_BUILD_DIR)/
	rm -rf $(PKG_INSTALL_DIR)
	mkdir -p $(PKG_INSTALL_DIR)
#	$(MAKE) -C $(PKG_BUILD_DIR)/app/convbin/gcc CC="$(TARGET_CC) $(TARGET_CFLAGS)"
#	$(MAKE) -C $(PKG_BUILD_DIR)/app/pos2kml/gcc CC="$(TARGET_CC) $(TARGET_CFLAGS)"
#	$(MAKE) -C $(PKG_BUILD_DIR)/app/rnx2rtkp/gcc CC="$(TARGET_CC) $(TARGET_CFLAGS)"
	$(MAKE) -C $(PKG_BUILD_DIR)/app/rtkrcv/gcc CC="$(TARGET_CC) $(TARGET_CFLAGS)"
	$(MAKE) -C $(PKG_BUILD_DIR)/app/str2str/gcc CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

#define Package/convbin/install
#	$(INSTALL_DIR) $(1)/usr/bin
#	$(INSTALL_BIN) $(PKG_BUILD_DIR)/app/convbin/gcc/convbin $(1)/usr/bin/
#endef

#define Package/pos2kml/install
#	$(INSTALL_DIR) $(1)/usr/bin
#	$(INSTALL_BIN) $(PKG_BUILD_DIR)/app/pos2kml/gcc/pos2kml $(1)/usr/bin/
#endef

#define Package/rnx2rtkp/install
#	$(INSTALL_DIR) $(1)/usr/bin
#	$(INSTALL_BIN) $(PKG_BUILD_DIR)/app/rnx2rtkp/gcc/rnx2rtkp $(1)/usr/bin/
#endef

define Package/rtkrcv/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/app/rtkrcv/gcc/rtkrcv $(1)/usr/bin/
endef

define Package/str2str/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/app/str2str/gcc/str2str $(1)/usr/bin/
endef

#$(eval $(call BuildPackage,convbin))
#$(eval $(call BuildPackage,pos2kml))
#$(eval $(call BuildPackage,rnx2rtkp))
$(eval $(call BuildPackage,rtkrcv))
$(eval $(call BuildPackage,str2str))
