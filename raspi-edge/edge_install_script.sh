
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
	cd $dir1
    cd $dir2
}

tunslip6Daemon()
{
    echo "\nInstall Tunslip6 Daemon..."
    cp system/tunslip6.service /lib/systemd/system/
    systemctl enable tunslip6.service
    cd $dir1
    cd $dir2
}

serial()
{
	echo "\nSerial activated..."
        systemctl stop serial-getty@ttyS0.service
        systemctl disable serial-getty@ttyS0.service
	cp boot/cmdline.txt /boot/cmdline.txt
    	cp boot/config.txt  /boot/config.txt
    cd $dir1
    cd $dir2
}


radvd()
{
        echo "\neth0 Static IPv6..."
        cp interfaces.d/eth0 /etc/interfaces.d/eth0
	echo "\nInstall RADVD..."
	apt-get install -y radvd
	cp etc/radvd.conf /etc/radvd.conf
	service radvd start
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
