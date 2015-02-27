#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt..."
	read -p "apt-get update (j/n)? " update
	case "$update" in
				j)	sudo apt-get -y update
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
	read -p "apt-get upgrade (j/n)? " upgrade
	case "$upgrade" in
				j)	sudo apt-get -y upgrade
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
	sudo cp modprobe.d/ipv6.conf /etc/modprobe.d/ipv6.conf						#git link
}

tunslip6()
{
	echo "\nInstall Tunslip6..."
	sudo wget https://raw.githubusercontent.com/osdomotics/osd-contiki/master/tools/tunslip6.c
	sudo gcc tunslip6.c -o tunslip6
	sudo chmod 766 tunslip6
	sudo cp tunslip6 /usr/sbin/
	sudo cp sbin/tunslip6.sh /usr/sbin/tunslip6.sh						#git link
	cd /usr/sbin/
	sudo chmod 766 tunslip6.sh
	cd $dir1
    cd $dir2
}

tunslip6Daemon()
{
	echo "\nInstall Tunslip6 Daemon..."
	sudo cp init.d/tunslip6 /etc/init.d/tunslip6							#git link
	cd /etc/init.d/
	sudo chmod a+x tunslip6
	#echo "\n insserv tunslip6"
	sudo insserv tunslip6
	cd $dir1
    cd $dir2	
}

serial()
{
	echo "\nSerial activated..."
	#cd /etc/
	sudo cp etc/inittab /etc/inittab										#git link
	#cd /boot/
	sudo cp boot/cmdline.txt /boot/cmdline.txt							#git link
}

radvd()
{
	echo "\nInstall RADVD..."
	sudo apt-get install -y radvd
	sudo cp etc/radvd.conf /etc/radvd.conf								#git link
	cd /etc/init.d
	sudo radvd start
	cd $dir1
    cd $dir2
}

read -p "Do you want to install Raspi-Edge-Package (j/n)? " response

case "$response" in
	j) 	echo "\nInstall Raspi-Edge-Package..."
		
		dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

		updateApt
		upgradeApt
		IPV6
		tunslip6
		tunslip6Daemon
		serial
		radvd
		echo "\nIf you want to use the full functionality, it is important to reboot your System."
		read -p "Do you want to reboot your System. (j/n)? " reboot
		
			case "$reboot" in
				j)	sudo reboot 
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
