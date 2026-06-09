#./scripts/feeds uninstall ddns-go  smartdns luci-app-ddns-go luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-ddns-go feeds/luci/applications/luci-app-passwall feeds/luci/applications/luci-app-smartdns 
rm -rf feeds/packages/net/alist feeds/packages/net/ddns-go feeds/packages/net/smartdns

echo "--------------------------------------start clone---------------------------------"
pwd
git clone https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns/
git clone https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns/

git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone https://github.com/sbwml/luci-app-openlist2 package/openlist2
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

ls package

echo "-------------------------------------end clone--------------------------------------"

# 针对 grub 编译极慢的压榨优化
if [ -d "package/boot/grub2" ]; then
    # 修改 grub 的 Makefile，在配置中加上禁用不需要的组件，减少无意义的串行编译
    sed -i 's/--disable-werror/--disable-werror --disable-efiemu --disable-grub-emu-usb --disable-nls/g' package/boot/grub2/Makefile
    echo "---------------------------------------- set grub2 finished-----------------------------------------------------"
    cat package/boot/grub2/Makefile
fi

