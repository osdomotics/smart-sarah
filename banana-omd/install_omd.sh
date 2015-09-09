#!/bin/sh
#$Id$

omd()
{
#	echo "\nExpand Filesystem..."
	read -p "Install OMD (y/n)? " omd
	case "$omd" in
				y)	echo "\nInstall OMD..."
					# Add our key:
					gpg --recv-keys 24BFF712
					gpg --armor --export 24BFF712 | apt-key add -
					# Add our repository for Debian 8 (jessie):
					echo "deb http://dl.bananian.org/packages/ jessie main" > /etc/apt/sources.list.d/bananian.list
					apt-get -y install omd-1.20
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
	read -p "Install COAP (y/n)? " coap
	case "$coap" in
				y)	echo "\nInstall coap..."
					sudo apt-get -y install libnagios-plugin-perl libnetaddr-ip-perl 
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
	read -p "Install CheckCOAP (y/n)? " checkcoap
	case "$checkcoap" in
				y)	sudo omd create mysite
	
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


read -p "Do you want to install Open Monitoring Distribution (y/n)? " response

case "$response" in
	y) 	echo "\nInstall OMD-Package..."
		
		dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

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
