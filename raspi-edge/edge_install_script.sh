
#!/bin/sh
#$Id$

updateApt()
{
    sudo apt-get -y update
}

upgradeApt()
{
    sudo apt-get -y upgrade
}

tunslip6()
{
	echo "\nInstall Tunslip6..."
	sudo wget https://raw.githubusercontent.com/osdomotics/osd-contiki/master/tools/tunslip6.c
	sudo gcc tunslip6.c -o tunslip6
	sudo chmod 766 tunslip6
	sudo cp tunslip6 /usr/sbin/
	sudo cp sbin/tunslip6.sh /usr/sbin/tunslip6.sh
	cd /usr/sbin/
	sudo chmod 766 tunslip6.sh
	cd $dir1
    cd $dir2
}

tunslip6Daemon()
{
	echo "\nInstall Tunslip6 Daemon..."
	sudo cp init.d/tunslip6 /etc/init.d/tunslip6
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
	sudo cp etc/inittab /etc/inittab
	sudo cp boot/cmdline.txt /boot/cmdline.txt
}

radvd()
{
	echo "\nInstall RADVD..."
	sudo apt-get install -y radvd
	sudo cp etc/radvd.conf /etc/radvd.conf
	cd /etc/init.d
	sudo radvd start
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
		tunslip6
		tunslip6Daemon
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
