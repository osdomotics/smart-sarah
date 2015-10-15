#! /bin/sh
echo -n "start border-router.natove .. ";
# disable autoconfiguration, enable eth0
echo 0 > /proc/sys/net/ipv6/conf/default/accept_ra
echo 1 > /proc/sys/net/ipv6/conf/eth0/accept_ra

# get panid from uboot
  panid="abcd"
# get lowpanprefix from uboot
  lowpanprefix="aaaa::"
# start daemon
#border-router.native -B 115200 -L -v2 -s ttyACM0 aaaa::1/64 &
/usr/sbin/border-router.native -B 115200 -L -v2 -s ttyACM0 ${lowpanprefix}1/64 &
sleep 10
ifconfig tun0 inet  up
#ifconfig tun0 fe80::1/64
#ifconfig tun0 ${lowpanprefix}1/64

# get mac address from uboot and calculate devaddr

devaddr="ba27:ebff:fef1:8e19"
# get ipprefix from uboot
echo "set eth0 ipv6 address"
  ipprefix="abbb::"

ifconfig eth0 add ${ipprefix}${devaddr}/64
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
sleep 2
# bird ripng
#/usr/sbin/buildbirdconf.sh
sleep 2
#bird -s var/run/bird6.ctl -c /etc/bird.conf
#/etc/init.d/bird6 restart &
# Radvd
/etc/init.d/radvd restart &
echo -n "done ";
#end

