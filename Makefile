include $(TOPDIR)/rules.mk

PKG_NAME:=usb-config-scripts
PKG_VERSION:=0.1.0
PKG_RELEASE:=3

PKG_BUILD_DIR:=$(BUILD_DIR)/usb-config-scripts-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/MaStr/usb-config-scripts/archive/
PKG_MD5SUM:=fe211e1e37530673600f31b1391a79cc
PKG_CAT:=zcat


include $(INCLUDE_DIR)/package.mk

define Package/usb-config-scripts
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Scripts for USB-Config files
  SUBMENU:=PirateBox
  URL:=http:///github.com/MaStr/usb-config-scripts
  DEPENDS:=
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
endef

define Package/usb-config-scripts-librarybox
  $(call Package/usb-config-scripts)
  TITLE+= with customizations for LibraryBox
endef 

define Package/usb-config-scripts/description
	Helps easier configuration via simple files on USB Stick for i.e. LibraryBox
endef




define Package/usb-config-scripts/postinst
endef


define Package/usb-config-scripts-librarybox/postinst
	#!/bin/sh
	ln -s /opt/autocfg/modules.available/*openwrt* /opt/autocfg/modules.enabled
	ln -s /opt/autocfg/modules.available/*librarybox* /opt/autocfg/modules.enabled
	ln -s /opt/autocfg/modules.available/50_piratebox_hostname.sh /opt/autocfg/modules.enabled
endef

define Build/Compile
endef

define Build/Configure
endef


define Package/usb-config-scripts/install
	$(INSTALL_DIR) $(1)/opt/autocfg
	$(INSTALL_DIR) $(1)/opt/autocfg/{bin,conf}
	$(INSTALL_DIR) $(1)/opt/autocfg/lib
	$(INSTALL_DIR) $(1)/opt/autocfg/modules.available
	$(INSTALL_DIR) $(1)/opt/autocfg/modules.enabled

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/* 	$(1)/opt/autocfg/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/conf/* 	$(1)/opt/autocfg/conf/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/* 	$(1)/opt/autocfg/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/modules.available/* 	$(1)/opt/autocfg/modules.available/
endef


Package/usb-config-scripts-librarybox/install=Package/usb-config-scripts/install

$(eval $(call BuildPackage,usb-config-scripts))
$(eval $(call BuildPackage,usb-config-scripts-librarybox))

