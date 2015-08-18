#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt..."
	read -p "apt-get update (y/n)? " update
	case "$update" in
				y)	apt-get -y update
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

upgradeApt()
{
	echo "\nUpgrade Apt..."
	read -p "apt-get upgrade (y/n)? " upgrade
	case "$upgrade" in
				y)	apt-get -y upgrade
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

IPV6()
{
	echo "\nUse IPv6..."
	cp modprobe.d/ipv6.conf /etc/modprobe.d/ipv6.conf						#git link
}

tunslip6()
{
	echo "\nInstall Tunslip6..."
	apt-get install build-essential
	wget https://raw.githubusercontent.com/osdomotics/osd-contiki/master/tools/tunslip6.c
	gcc tunslip6.c -o tunslip6
	chmod 766 tunslip6
	cp tunslip6 /usr/sbin/
	cp sbin/tunslip6.sh /usr/sbin/tunslip6.sh						#git link
	cd /usr/sbin/
	chmod 766 tunslip6.sh
	cd $dir1
    cd $dir2
}

tunslip6Daemon()
{
	echo "\nInstall Tunslip6 Daemon..."
	cp init.d/tunslip6 /etc/init.d/tunslip6							#git link
	cd /etc/init.d/
	chmod a+x tunslip6
	#echo "\n insserv tunslip6"
	insserv tunslip6
	cd $dir1
    cd $dir2	
}

serial()
{
	echo "\nSerial activated..."
	#cd /etc/
	cp etc/inittab /etc/inittab										#git link
	#cd /boot/
	cp boot/cmdline.txt /boot/cmdline.txt							#git link
}

radvd()
{
	echo "\nInstall RADVD..."
	apt-get install -y radvd
	cp etc/radvd.conf /etc/radvd.conf								#git link
	cd /etc/init.d
	radvd start
	cd $dir1
    cd $dir2
}

read -p "Do you want to install Raspi-Edge-Package (y/n)? " response

case "$response" in
	y) 	echo "\nInstall Raspi-Edge-Package..."
		
		dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

		updateApt
		upgradeApt
		#IPV6
		tunslip6
		tunslip6Daemon
		#serial
		radvd
		echo "\nIf you want to use the full functionality, it is important to reboot your System."
		read -p "Do you want to reboot your System. (y/n)? " reboot
		
			case "$reboot" in
				y)	reboot 
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
