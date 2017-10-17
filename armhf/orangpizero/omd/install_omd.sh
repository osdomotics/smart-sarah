#!/bin/sh
#$Id$

instomd()
{
        # Add our key:
        #gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7
        #gpg --armor --export F8C1CA08A57B9ED7 | apt-key add -
        # if the above command fails for any reason, server not available etc…
        #wget -q "https://labs.consol.de/repo/stable/RPM-GPG-KEY" -O - | sudo apt-key add -
        # Add our repository for Debian 8 (jessie):
        #echo "deb http://labs.consol.de/repo/stable/debian $(lsb_release -cs) main" > /etc/apt/sources.list.d/labs-consol-stable.list
        #apt-get -y update
        #apt-get -y install omd
        #echo "\n Install OMD- END"

        # Add our key:
        # gpg --recv-keys 24BFF712
        # gpg --armor --export 24BFF712 | apt-key add -
        # if the above command fails for any reason, server not available etc…
	wget -q "https://dl.bananian.org/packages/bananian-packages.key" -O - | sudo apt-key add -
        # Add our repository for Debian 8 (jessie):
        echo "deb http://dl.bananian.org/packages/ jessie main" > /etc/apt/sources.list.d/bananian.list
        apt-get -y update
        apt-get -y install omd-1.30
        echo "\n Install OMD- END"

}

coap()
{
        echo "\nInstall coap-client"
        apt-get -y install libnagios-plugin-perl libnetaddr-ip-perl 
        cp bin/coap-client /usr/local/bin/
        cd $dir1
        cd $dir2
        echo "\n Install COAP- END"
}

checkcoap()
{
        omd create mysite
        git clone https://github.com/osdomotics/check_coap.git
        wget https://github.com/osdomotics/check_coap/archive/master.zip
        unzip master.zip
        cp ./check_coap-master/check_coap* /omd/sites/mysite/lib/nagios/plugins/
#        cp ./conf.d/coap_templates.cfg /omd/sites/mysite/etc/nagios/conf.d/
        cp ./conf.d/sarah_hosts.cfg /omd/sites/mysite/etc/nagios/conf.d/
        a2dismod ssl
        omd stop
        omd start
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
