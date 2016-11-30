#!/bin/sh
#$Id$

instomd()
{
        # Add our key:
        gpg --recv-keys 24BFF712
        gpg --armor --export 24BFF712 | apt-key add -
        # Add our repository for Debian 8 (jessie):
        echo "deb http://dl.bananian.org/packages/ jessie main" > /etc/apt/sources.list.d/bananian.list
        apt-get -y update
        apt-get -y install omd-1.30
        echo "\n Install OMD- END"
}

coap()
{
        echo "\nInstall coap..."
        apt-get -y install libnagios-plugin-perl libnetaddr-ip-perl 
        wget http://downloads.sourceforge.net/project/libcoap/coap-18/libcoap-4.0.3.tar.gz
        tar -xzf libcoap-4.0.3.tar.gz
        cd libcoap-4.0.3
        apt-get -y install autoconf
        autoconf
        ./configure
        make
        cp examples/coap-client /usr/local/bin/
        cd $dir1
        cd $dir2
        echo "\n Install COAP- END"
}

checkcoap()
{
        omd create mysite
        git clone https://github.com/osdomotics/check_coap.git
        cd check_coap/
        cp check_coap* /omd/sites/mysite/lib/nagios/plugins/
        cd nagios-conf.d/
#        cp coap_templates.cfg /omd/sites/mysite/etc/nagios/conf.d/
        cp sarah_hosts.cfg /omd/sites/mysite/etc/nagios/conf.d/
        cd $dir1
        cd $dir2
        echo "\n Install CHECKCOAP- END"
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

		instomd
		coap
		checkcoap
		omd restart
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
