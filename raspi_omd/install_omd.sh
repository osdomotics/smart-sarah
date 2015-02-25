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

expandfile()
{
	echo "\nExpand Filesystem..."
	read -p "Do you want to expand your Filesystem (j/n)? " expandfile
	case "$expandfile" in
				j)	echo "Its important to reboot afterwards and start the script again"
					sudo raspi-config
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

omd()
{
#	echo "\nExpand Filesystem..."
	read -p "Install OMD (j/n)? " omd
	case "$omd" in
				j)	echo "\nInstall OMD..."
					mkdir omd
					cd omd
					wget http://labs.consol.de/repo/stable/debian/dists/wheezy/main/binary-armhf/omd-1.00_0.wheezy_armhf.deb
					sudo apt-get -y install time traceroute curl dialog dnsutils fping graphviz libapache2-mod-fcgid libapache2-mod-proxy-html libboost-program-options1.49.0 libdbi-dev libevent-2.0-5 libgd2-xpm libltdl7 libnet-snmp-perl libpango1.0-0 libperl5.14 libreadline6 libsnmp-perl libuuid1 libpython2.7 mysql-server patch php5 php5-cgi php5-cli php5-gd php5-mcrypt php5-sqlite php-pear rsync snmp unzip xinetd xvfb python-ldap
					sudo apt-get -f -y install
					echo "\n Install OMD-dpkg..."
					sudo dpkg -i omd-1.00_0.wheezy_armhf.deb
					echo "\n Install OMD- END"
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
	
}

coap()
{
#	echo "\nExpand Filesystem..."
	read -p "Install COAP (j/n)? " coap
	case "$coap" in
				j)	echo "\nInstall coap..."
					sudo apt-get -y install libnagios-plugin-perl libnetaddr-ip-perl 
					echo "\nInstall apache2-mpm-prefork..."
					sudo apt-get -y install apache2-mpm-prefork
					echo "\n apt-get -f install"
					sudo apt-get -f -y install
					echo "\nWget..."
					wget http://downloads.sourceforge.net/project/libcoap/coap-18/libcoap-4.0.3.tar.gz
					echo "\nTar..."
					tar -xzf libcoap-4.0.3.tar.gz
					echo "\ncd lib..."
					cd libcoap-4.0.3
					echo "\nInstall autoconf..."
					sudo apt-get -y install autoconf
					echo "\nAutoconf..."
					autoconf
					echo "\n./Configure..."
					./configure
					echo "\nMake..."
					make
					echo "\nCoap_client cp..."
					sudo cp examples/coap-client /usr/local/bin/
					echo "\n Install COAP- END"
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
	
}

checkcoap()
{
#	echo "\nExpand Filesystem..."
	read -p "Install CheckCOAP (j/n)? " checkcoap
	case "$checkcoap" in
				j)	sudo omd create mysite
	
					cd $dir1
					cd $dir2
					
					git clone https://github.com/osdomotics/check_coap.git
					cd check_coap/
					sudo cp check_coap* /omd/sites/mysite/lib/nagios/plugins/
					cd nagios-conf.d/
					sudo cp coap_templates.cfg /omd/sites/mysite/etc/nagios/conf.d/
					sudo cp triops.cfg /omd/sites/mysite/etc/nagios/conf.d/	
					
					cd $dir1
					cd $dir2
					pwd
					sudo cp conf.d/coap_templates.cfg /omd/sites/mysite/etc/nagios/conf.d/
					sudo cp conf.d/triops.cfg /omd/sites/mysite/etc/nagios/conf.d/
					echo "\n Install CHECKCOAP- END"
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
	
}


read -p "Do you want to install Open Monitoring Distribution (j/n)? " response

case "$response" in
	j) 	echo "\nInstall OMD-Package..."
		
		dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

		updateApt
		upgradeApt
		expandfile
		omd
		coap
		checkcoap
		sudo omd restart
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
