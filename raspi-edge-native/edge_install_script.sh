#!/bin/sh
#$Id$

updateApt()
{
	apt-get -y update
}

upgradeApt()
{
	apt-get -y upgrade
}

BorderRouter()
{
	echo "\nInstall border-router.native ..."
	chmod 766 sbin/border-router.native
	cp sbin/border-router.native /usr/sbin/
	cp sbin/border-router.sh /usr/sbin/						#git link
	cd /usr/sbin/
	chmod 766 border-router.sh
	cd $dir1
	cd $dir2
}

BorderRouterDaemon()
{
	echo "\nInstall border-router Daemon..."
	cp init.d/border-router /etc/init.d/border-router							#git link
	cd /etc/init.d/
	chmod a+x border-router
	#echo "\n insserv border-router"
	insserv border-router
	cd $dir1
	cd $dir2	
}

serial()
{
	echo "\nSerial activated..."
	cp etc/inittab /etc/inittab
	cp boot/cmdline.txt /boot/cmdline.txt							#git link
}

radvd()
{
	echo "\nInstall RADVD..."
	apt-get install -y radvd
	cp etc/radvd.conf /etc/radvd.conf
        cp etc/sysctl.conf /etc/sysctl.conf								#git link
	cd /etc/init.d
	radvd start
	cd $dir1
	cd $dir2
}

read -p "Do you want to install Raspi-Edge-Native-Package (y/n)? " response

case "$response" in
	y) 	echo "\nInstall Raspi-Edge-Native-Package..."
		
	dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

		updateApt
		upgradeApt
		BorderRouter
		BorderRouterDaemon
		serial
		radvd
		echo "\nIf you want to use the full functionality, it is important to reboot your System."
		read -p "Do you want to reboot your System. (y/n)? " reboot
		
			case "$reboot" in
				y)	sudo reboot 
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
