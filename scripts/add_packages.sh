#!/bin/bash

# {{ Add luci-app-diskman
(cd friendlywrt/package && {
    [ -d luci-app-diskman ] && rm -rf luci-app-diskman
    git clone https://github.com/lisaac/luci-app-diskman --depth 1 -b master
})
# }}

# {{ Add luci-theme-argon
(cd friendlywrt/package && {
    [ -d luci-theme-argon ] && rm -rf luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git --depth 1 -b v2.4.3
})
# add argon config
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> configs/rockchip/01-nanopi
# }}

# {{ Change device/friendlyelec/rk3399/base.mk
sed -i 's|FRIENDLYWRT_FILES+=(device/common/nft-fullcone)|#FRIENDLYWRT_FILES+=(device/common/nft-fullcone)|g' device/friendlyelec/rk3399/base.mk
sed -i 's|FRIENDLYWRT_FILES+=(device/common/emmc-tools)|#FRIENDLYWRT_FILES+=(device/common/emmc-tools)|g' device/friendlyelec/rk3399/base.mk
sed -i 's|FRIENDLYWRT_FILES+=(device/friendlyelec/rk3399/r8169)|#FRIENDLYWRT_FILES+=(device/friendlyelec/rk3399/r8169)|g' device/friendlyelec/rk3399/base.mk
# }}

