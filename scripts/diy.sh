#!/bin/bash

# {{ Replace go-lang
#rm -rf friendlywrt/feeds/packages/lang/golang
#git clone -b 26.x --depth 1 https://github.com/sbwml/packages_lang_golang friendlywrt/feeds/packages/lang/golang
# }}

# {{ Remove old packages , add luci-app-passwall and passwall-packages
#rm -rf friendlywrt/feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
#rm -rf friendlywrt/package/feeds/packages/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
#(cd friendlywrt/package && {
#    [ -d passwall-luci ] && rm -rf passwall-packages
#    git clone -b main --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages passwall-packages
#})
#(cd friendlywrt/package && {
#    [ -d passwall-luci ] && rm -rf passwall-luci
#    git clone -b 26.6.2-1 --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall passwall-luci
#})
# }}

# {{ Replace luci-app-cpufreq
#rm -rf friendlywrt/package/friendlyelec/luci-app-cpufreq
#(cd friendlywrt/package && {
#    [ -d luci-app-cpufreq ] && rm -rf luci-app-cpufreq
#    cp -r ../../../packages/luci-app-cpufreq ./
#    [ -d cpufreq ] && rm -rf cpufreq
#    cp -r ../../../packages/cpufreq ./
#})
# }}

# {{ Modify default theme
sed -i 's|luci-theme-bootstrap|luci-theme-argon|g' friendlywrt/feeds/luci/collections/luci-light/Makefile
# }}

# {{ Modify smb
sed -i -e 's|ports = 445|ports = 445 25445|g' friendlywrt/feeds/packages/net/samba4/files/samba.init
sed -i -e 's|invalid users = root|#invalid users = root|g' friendlywrt/feeds/packages/net/samba4/files/smb.conf.template
sed -i -e 's|null passwords = yes|#null passwords = yes|g' friendlywrt/feeds/packages/net/samba4/files/smb.conf.template
sed -i -e 's|#dns proxy = No|dns proxy = No|g' friendlywrt/feeds/packages/net/samba4/files/smb.conf.template
# }}

# {{ Modify hostname
sed -i -e 's|OpenWrt|NanoPC-T6|g' friendlywrt/package/base-files/files/bin/config_generate
# }}

# {{ Change ash to bash
sed -i -e 's|/bin/ash|/bin/bash|g' friendlywrt/package/base-files/files/etc/passwd
# }}

# {{ Change root password
sed -i -e 's|root:$1$sI9XK.bT$vfaeX5elDEUyrgC11IfGT/:0:0:99999:7:::|root:$1$CVCXbKh9$r5w6F.rsYfy3Uszzi7TuD0:8210:0:99999:7:::|g' friendlywrt/package/base-files/files/etc/shadow
# }}

# {{ Replace bg1.jpg
mv -f ../bg1.jpg friendlywrt/package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
# }}

# {{ Modify luci footer
sed -i -e '23,33d' friendlywrt/package/luci-theme-argon/luasrc/view/themes/argon/footer.htm
# }}

# {{ Modify luci footer login
sed -i -e '24,26d' friendlywrt/package/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm
# }}

# {{ Modify luci header to remove X-Frame-Options
sed -i -e '71d' friendlywrt/package/luci-theme-argon/luasrc/view/themes/argon/header.htm
# }}

# {{ Modify luci header login to remove X-Frame-Options
sed -i -e '68d' friendlywrt/package/luci-theme-argon/luasrc/view/themes/argon/header_login.htm
# }}

# {{ Change ttyd from services to system
sed -i -e 's|/services/|/system/|g' friendlywrt/feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
# }}

# {{ Change samba4 from services to nas
sed -i -e 's|/services/|/nas/|g' friendlywrt/feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json
sed -i -e '/"admin\/system": {/,/^\t},$/ {
    /^\t},$/ {
        s/$/\
\
\t"admin\/nas": {\
\t\t"title": "NAS",\
\t\t"order": 30,\
\t\t"action": {\
\t\t\t"type": "firstchild",\
\t\t\t"recurse": true\
\t\t}\
\t},/
    }
}' friendlywrt/feeds/luci/modules/luci-base/root/usr/share/luci/menu.d/luci-base.json
# }}

# {{ Copy files
mv -f ../files friendlywrt/files
# }}

# {{ Replace setup.sh
mv -f ../scripts/setup.sh friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh
# }}

