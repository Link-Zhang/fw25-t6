#!/bin/bash

. /lib/functions/uci-defaults.sh
. /lib/functions/system.sh

function init_firewall() {
	uci set firewall.@defaults[0].input='ACCEPT'
	uci set firewall.@defaults[0].output='ACCEPT'
	uci set firewall.@defaults[0].forward='ACCEPT'
	uci set firewall.@defaults[0].flow_offloading='0'
	uci commit firewall
	fw4 reload
}

function init_system() {
	[ -e /usr/bin/ip ] || ln -sf /sbin/ip /usr/bin/ip
	[ -e /etc/crontabs/root ] || touch /etc/crontabs/root
	uci -q batch <<-EOF
		set system.@system[-1].hostname='$HOSTNAME'
		set system.@system[-1].ttylogin='1'
		set system.@system[-1].timezone=CST-8
		set system.@system[-1].zonename=Asia/Shanghai
		commit system
	EOF
}

function init_theme() {
	if uci get luci.themes.Argon >/dev/null 2>&1; then
		uci set luci.main.mediaurlbase="/luci-static/argon"
		uci commit luci
	fi
}

function init_root_vimrc() {
	[ -f /root/.vimrc ] && return 0

	cat > /root/.vimrc <<-EOF
		version 9.0
		
		set encoding=utf-8
		set hlsearch
		set incsearch
		set number
		set shiftwidth=4
		set tabstop=4
	EOF
}

function init_button() {
	local CONF=/etc/triggerhappy/triggers.d/example.conf
	grep "BTN_1" ${CONF} >/dev/null && return 0
	[ -f ${CONF} ] && echo 'BTN_1 1 /sbin/reboot' >> ${CONF}
}

function init_dropbear() {
	[ -d /root/.ssh ] && chmod 700 /root/.ssh
	[ -f /root/.ssh/authorized_keys ] && chmod 600 /root/.ssh/authorized_keys
	[ -f /root/.ssh/id_dropbear ] && chmod 600 /root/.ssh/id_dropbear
	[ -f /root/.ssh/id_dropbear.pub ] && chmod 644 /root/.ssh/id_dropbear.pub
}

function clean_fstab() {
	# delete all entries but keep /opt
	local index=0
	while uci -q get fstab.@mount[$index]; do
		local target=$(uci -q get fstab.@mount[$index].target)
		if [ "$target" = "/opt" ]; then
			index=$((index + 1))
		else
			uci -q del fstab.@mount[$index]
			# do not increment index because the remaining entries will shift forward after deletion
		fi
	done
	uci commit fstab
}

function init_zsh() {
	curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh > /root/install.sh
	chmod 777 /root/install.sh
	sed -i 's|REPO=${REPO:-ohmyzsh/ohmyzsh}|REPO=${REPO:-mirrors/oh-my-zsh}|g' /root/install.sh
	sed -i 's|REMOTE=${REMOTE:-https://github.com/${REPO}.git}|REMOTE=${REMOTE:-https://gitee.com/${REPO}.git}|g' /root/install.sh
	echo y | /root/install.sh
	rm -rf /root/install.sh
	sed -i '1iexport TZ="Asia/Shanghai"' /root/.zshrc
	sed -i '1iexport TERM="xterm"' /root/.zshrc
	sed -i '1iexport USER=$(whoami)' /root/.zshrc
	sed -i '1iexport LC_ALL="en_US.UTF-8"' /root/.zshrc
	sed -i '1iexport LANGUAGE="en_US.UTF-8"' /root/.zshrc
	sed -i '1iexport LANG="en_US.UTF-8"' /root/.zshrc
	sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="agnoster"|g' /root/.zshrc
	sed -i 's|# HIST_STAMPS="mm/dd/yyyy"|HIST_STAMPS="yyyy-mm-dd"|g' /root/.zshrc
	sed -i "s|# zstyle ':omz:update' mode disabled|zstyle ':omz:update' mode disabled|g" /root/.zshrc
	cat > /root/.zprofile <<-EOF
		if [ -f /etc/banner ]; then
			cat /etc/banner
		fi
	EOF
	sed -i 's|/bin/bash|/usr/bin/zsh|g' /etc/passwd
}

HOSTNAME="NanoPC-T6"

if [ "${1}" = "all" ]; then
	init_firewall
	init_system
	init_theme
	init_root_vimrc
	init_button
	init_dropbear
	clean_fstab
fi

