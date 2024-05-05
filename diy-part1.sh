#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

git config user.name "someone"
git config user.email "someone@someplace.com"

git revert 722c2739ba62dcadc2a4b2ce0b92c1a34991c29e
git revert 8c6cc8f468334adfd808628430c19ff0fb731bb9

+#src-git helloworld https://github.com/fw876/helloworld.git;main
+src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main
+src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;luci-smartdns-dev
+src-git kenzo https://github.com/kenzok8/openwrt-packages
+#src-git small https://github.com/kenzok8/small
+src-git infinityfreedom https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git

echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;luci-smartdns-dev' >>feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git infinityfreedom https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git' >>feeds.conf.default
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone https://github.com/sbwml/luci-app-alist.git package/alist
