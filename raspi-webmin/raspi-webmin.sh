#!/bin/bash
apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget 'http://downloads.sourceforge.net/project/webadmin/webmin/1.820/webmin_1.820_all.deb'
dpkg --install webmin_1.820_all.deb
