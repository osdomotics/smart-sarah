#!/bin/sh
# $Id$

updateApt()
{
	echo "Update Apt..."
	apt-get -y update
	apt-get -y install tmux vim
	apt-get -y install libmysqlclient-dev liblog4cpp5-dev libxml2-dev libesmtp-dev liblua5.1-0-dev libcurl4-openssl-dev
}

installPthsem()
{
	echo "Load and install pthsem..."
	cd /tmp
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Packs/pthsem_2.0.8-1_armhf.deb
	dpkg -i pthsem_2.0.8-1_armhf.deb
	LD_LIBRARY_PATH="/usr/lib/"
	ldconfig
}

installEibd()
{
	echo "Load and install EIBD (BCUSDK)..."
	cd /tmp
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Packs/eibd_0.0.5-1_armhf.deb
	dpkg -i eibd_0.0.5-1_armhf.deb
	cd /etc/init.d
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Scripts/eibd
	chmod a+x eibd
	update-rc.d eibd defaults
}

installLinknx()
{
	echo "Load and install Linknx..."
	cd /tmp
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Packs/linknx_0.0.1.30-1_armhf.deb 
	dpkg -i linknx_0.0.1.30-1_armhf.deb 
	cd /etc/init.d
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Scripts/linknx
	chmod a+x linknx
	update-rc.d linknx defaults
	mkdir /var/lib/linknx/
	mkdir /var/lib/linknx/persist/
	mkdir /var/lib/linknx/persistlog/
	touch /var/lib/linknx/logging.conf
	chmod a+rw /var/lib/linknx/logging.conf
	cd /etc
	wget -N https://github.com/selfbus/linux-bus-tools/raw/master/raspberry/Scripts/linknx.xml
	chmod a+rw linknx.xml
}

installKnxWeb2()
{
	cd /tmp
	wget -O knxweb2.tar "http://linknx.cvs.sourceforge.net/viewvc/linknx/knxweb/knxweb2/?view=tar"
	tar xvf knxweb2.tar -C /var/www
	chown -R www-data /var/www/knxweb2/pictures/
	chown -R www-data /var/www/knxweb2/design/ 
	mkdir /var/www/knxweb2/template/template_c/ 
	chown -R www-data /var/www/knxweb2/template/template_c/
	chown -R www-data /var/www/knxweb2/include/ 
	rm /var/www/knxweb2/design/.empty
	
}

updateApt
installPthsem
installEibd
installLinknx
installKnxWeb2
