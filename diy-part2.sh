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



#修改默认IP地址
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname=Me-X86-Router/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/OpenWrt/Me-X86-Router/g' package/base-files/files/bin/config_generate

mkdir -p files/etc/hotplug.d/iface
cat > files/etc/hotplug.d/iface/99-myiface <<'EOF'
#!/bin/sh

# 检查事件是否为 WAN 接口的 "ifup"（连接建立）
logger "custom_wan called. $INTERFACE - $ACTION"
[ "$INTERFACE" = "WAN" ] && [ "$ACTION" = "ifupdate" ] && {
    # 在这里添加你希望执行的任务
    logger "WAN interface reconnected, running custom task..."
    # 示例：执行某个命令或脚本
    /etc/init.d/dockerd restart
}
EOF
chmod +x files/etc/hotplug.d/iface/99-myiface

# 确保在 OpenWrt 根目录下操作
cd /home/runner/work/OpenWrt-X86/OpenWrt-X86/openwrt

# 1. 确认目标目录存在（去掉隐形乱码）
ls -ld feeds/packages/utils/dockerd

# 2. 进入 packages 目录并下载补丁文件
cd feeds/packages
curl -sSL https://github.com/openwrt/packages/pull/30288.patch -o dockerd_fix.patch

# 3. 校验并应用补丁
if [ -s dockerd_fix.patch ]; then
    git apply --ignore-whitespace --whitespace=nowarn dockerd_fix.patch && echo "Patch applied successfully!"
    rm -f dockerd_fix.patch
else
    echo "Error: Downloaded patch file is empty!"
    exit 1
fi
tree feeds/packages/‎utils/dockerd/
# 4. 返回根目录重新刷新 install
cd ../..
./scripts/feeds install -a -p packages
