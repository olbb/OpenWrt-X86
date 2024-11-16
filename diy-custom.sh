rm -rf feeds/luci/applications/luci-app-alist feeds/luci/applications/luci-app-ddns-go feeds/luci/applications/luci-app-passwall feeds/luci/applications/luci-app-smartdns feeds/luci/applications/luci-app-dockerman 
rm -rf feeds/packages/net/alist feeds/packages/net/ddns-go feeds/packages/net/smartdns
git clone https://github.com/olbb/openwrt-smartdns.git feeds/packages/net/smartdns/
git clone https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns/
git clone https://github.com/lisaac/luci-app-dockerman.git feeds/luci/applications/luci-app-dockerman/
