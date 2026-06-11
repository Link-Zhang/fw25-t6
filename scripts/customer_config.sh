#!/bin/bash

sed -i -e 's|FRIENDLYWRT_FILES+=(device/common/emmc-tools)|#FRIENDLYWRT_FILES+=(device/common/emmc-tools)|g' device/friendlyelec/rk3588/base.mk
#sed -i -e 's|FRIENDLYWRT_FILES+=(device/friendlyelec/rk3588/r8125)|#FRIENDLYWRT_FILES+=(device/friendlyelec/rk3588/r8125)|g' device/friendlyelec/rk3588/base.mk
#sed -i -e 's|ENABLE_OPT_PARTITION=true|ENABLE_OPT_PARTITION=false|g' device/friendlyelec/rk3588/base.mk
#echo 'ENABLE_OVERLAYFS=false' >> device/friendlyelec/rk3588/base.mk
rm -rf device/common/src-patchs/25.12/feeds/luci/0002-luci-mod-system-replace-sysupgrade-flash-section-wit.patch

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-adblock=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-aria2=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-commands=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-hd-idle=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-minidlna=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-nlbwmon=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-smartdns=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-sqm=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-upnp=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-watchcat=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-theme-material=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-theme-openwrt-2020=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-proto-3g=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-mod-dashboard=m/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-proto-3g=y/d' configs/rockchip/01-nanopi

sed -i -e 's|CONFIG_TARGET_rockchip_armv8_DEVICE_friendlyarm_nanopi-r2s=y|CONFIG_TARGET_rockchip_armv8_DEVICE_friendlyarm_nanopc-t6=y|g' configs/rockchip/01-nanopi

# keep en and zh_Hans
sed -i -e '/^CONFIG_LUCI_LANG_en=y$\|^CONFIG_LUCI_LANG_zh_Hans=y$/!d' configs/rockchip/02-luci_lang

sed -i -e '/CONFIG_PACKAGE_CFG80211_TESTMODE=y/d' configs/rockchip/03-custom

# keep wifi ax200
sed -i -e '/^CONFIG_PACKAGE_iwlwifi-firmware-ax200=y$/!d' configs/rockchip/05-wifi