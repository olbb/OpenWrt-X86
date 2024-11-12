#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config

./scripts/feeds uninstal ddns-go
./scripts/feeds uninstal alist
./scripts/feeds uninstal smartdns
./scripts/feeds uninstal luci-app-ddns-go
./scripts/feeds uninstal luci-app-alist
./scripts/feeds uninstal luci-app-smartdns


git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone https://github.com/sbwml/luci-app-alist.git package/alist
git clone https://github.com/olbb/openwrt-smartdns feeds/packages/net/smartdns/
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter


sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/OpenWrt/Me-X86-Router/g' package/base-files/files/bin/config_generate
