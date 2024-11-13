rm -rf feeds/luci/applications/luci-app-alist feeds/luci/applications/luci-app-ddns-go feeds/luci/applications/luci-app-passwall feeds/luci/applications/luci-app-smartdns
rm -rf feeds/packages/net/alist feeds/packages/net/ddns-go feeds/packages/net/smartdns
git clone https://github.com/olbb/openwrt-smartdns.git feeds/packages/net/smartdns/
