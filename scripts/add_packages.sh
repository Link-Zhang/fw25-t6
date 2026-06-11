#!/bin/bash

# {{ Add luci-app-diskman
#(cd friendlywrt/package && {
#    [ -d luci-app-diskman ] && rm -rf luci-app-diskman
#    git clone https://github.com/lisaac/luci-app-diskman --depth 1 -b master
#})
# }}

# {{ Add luci-theme-argon
(cd friendlywrt/package && {
    [ -d luci-theme-argon ] && rm -rf luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git --depth 1 -b v2.4.3
})
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> configs/rockchip/01-nanopi
# }}