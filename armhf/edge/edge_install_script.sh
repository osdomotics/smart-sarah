
#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt..."
	apt-get -y update
}

upgradeApt()
{
	echo "\nUpgrade Apt..."
	apt-get -y upgrade
}

BorderRouter()
{
	echo "\nInstall border-router.native ..."
	chmod 766 sbin/tunslip6
	cp sbin/tunslip6 /usr/sbin/
        apt-get install -y net-tools
	cd $dir1
        cd $dir2
}

BorderRouterDaemon()
{
	echo "\nInstall border-router Daemon..."
	cp system/boarder-router.service /lib/systemd/system/
	systemctl enable boarder-router.service
	cd $dir1
        cd $dir2
}

radvd()
{
	echo "\nInstall RADVD..."
	apt-get install -y radvd
	cp etc/radvd.conf /etc/radvd.conf								#git link
        cp etc/sysctl.conf /etc/sysctl.conf
	service radvd start
}

read -p "Do you want to install Raspi-Edge-Native-Package (y/n)? " response

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
		BorderRouter
		BorderRouterDaemon
		radvd
		echo "\nIf you want to use the full functionality, it is important to reboot your System."
		read -p "Do you want to reboot your System. (y/n)? " reboot
		
			case "$reboot" in
				y)	reboot 
					;;
				n)	echo "Close..."
					;;
				*)	echo "false inpyut"
					;;
			esac
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
