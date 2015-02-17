#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt...\n"
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
	echo "\nUpgrade Apt...\n"
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
	echo "\nUse IPv6...\n"
	sudo cp /home/pi/raspi_edge/modprobe.d/ipv6.conf /etc/modprobe.d/ipv6.conf						#git link
}

tunslip6()
{
	echo "\nInstall Tunslip6...\n"
	sudo wget https://raw.githubusercontent.com/osdomotics/osd-contiki/master/tools/tunslip6.c
	sudo gcc tunslip6.c -o tunslip6
	sudo chmod 766 tunslip6
	sudo cp tunslip6 /usr/sbin/
	cd /usr/sbin/
	sudo cp /home/pi/raspi_edge/sbin/tunslip6.sh /usr/sbin/tunslip6.sh						#git link
	sudo chmod 766 tunslip6.sh
}

tunslip6Daemon()
{
	echo "\nInstall Tunslip6 Daemon...\n"
	sudo cp /home/pi/raspi_edge/init.d/tunslip6 /etc/init.d/tunslip6							#git link
	cd /etc/init.d/
	sudo chmod a+x tunslip6
	echo "\n insserv tunslip6"
	sudo insserv tunslip6	
}

serial()
{
	echo "\nSerial activated...\n"
	cd /etc/
	sudo cp /home/pi/raspi_edge/etc/inittab /etc/inittab										#git link
	cd /boot/
	sudo cp /home/pi/raspi_edge/boot/cmdline.txt /boot/cmdline.txt							#git link
}

radvd()
{
	echo "\nInstall RADVD...\n"
	sudo apt-get install -y radvd
	sudo cp /home/pi/raspi_edge/etc/radvd.conf /etc/radvd.conf								#git link
	cd /etc/init.d
	sudo radvd start
}

read -p "Do you want to install Raspi-Edge-Package (j/n)? " response

case "$response" in
	j) 	echo "\nInstall Raspi-Edge-Package...\n"
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
