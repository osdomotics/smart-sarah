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

tunslip6()
{
	echo "\nInstall Tunslip6..."
	wget https://github.com/osdomotics/osd-contiki/archive/osd.zip
        unzip osd.zip
	cd osd-contiki-osd/tools/
	make tunslip6
	chmod 766 tunslip6
	cp tunslip6 /usr/sbin/
	cp sbin/tunslip6.sh /usr/sbin/tunslip6.sh
	cd /usr/sbin/
	chmod 766 tunslip6.sh
	cd $dir1
    cd $dir2
}

tunslip6Daemon()
{
	echo "\nInstall Tunslip6 Daemon..."
	cp init.d/tunslip6 /etc/init.d/tunslip6
	cd /etc/init.d/
	chmod a+x tunslip6
	#echo "\n insserv tunslip6"
	insserv tunslip6
	cd $dir1
    cd $dir2	
}

radvd()
{
	echo "\nInstall RADVD..."
	apt-get install -y radvd
	cp etc/radvd.conf /etc/radvd.conf
    service radvd start
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

		updateApt
		upgradeApt
		tunslip6
		tunslip6Daemon
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
