smart-sarah
===========

System Service installer for Smart-SARAH Home-Automation System

Services

    * Webmin (The admin panel your servers deserve)
    * 6loWPAN router for IEEE 802.15.4
    * OMD (Open Monitoring Distribution)
    * Node-Red (A visual web-tool for wiring the Internet of Things)
    * wifiap (banana-pro as wlan access point)
    * Linwebknx (Home Automation Software)
    * Meteor-js deploy server (run a meteor app on a banana pi/pro)    

Requirements
------------
Debian-Alwinner Hardware
========================

Install Debian on your arm-hf Hardware

https://wiki.debian.org/InstallingDebianOn/Allwinner

http://ftp.uk.debian.org/debian/dists/stretch/main/installer-armhf/current/images/netboot/SD-card-images/

    #login as root
    apt-get install unzip
    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    #6loWPAN router for IEEE 802.15.4
    cd smart-sarah-master/armhf/edge-native
    ./edge_install_script.sh
    cd ..

Banana-Pro:

Bananian Linux 16.04 released - 2016-04-23

Go and download the latest version from the official site https://www.bananian.org/download Flash the image file to your SD card following the instruction on that website, that has to be at least 2GB.


Quickstart
----------
banana-pro:

    #login as root
    apt-get install unzip
    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    #6loWPAN router for IEEE 802.15.4
    cd smart-sarah-master/banana-edge/
    ./edge_install_script.sh
    cd ..
    #OMD (Open Monitoring Distribution)
    cd banana-omd
    ./install_omd.sh
    cd ..
    #Webmin (The admin panel your servers deserve)
    cd banana-webmin
    ./install_webmin.sh
    cd ..
    #Node-Red (A visual web-tool for wiring the Internet of Things)
    cd banana-nodered
    ./install_nodeRed.sh 
    cd ..

A20-OLinuXIno-LIME2(beta):

    #login as root
    apt-get install unzip
    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    #6loWPAN router for IEEE 802.15.4
    cd smart-sarah-master/banana-edge/
    ./edge_install_script.sh
    cd ..
    #OMD (Open Monitoring Distribution)
    cd banana-omd
    ./install_omd.sh
    cd ..
    #Webmin (The admin panel your servers deserve)
    cd banana-webmin
    ./install_webmin.sh
    cd ..
    #Node-Red (A visual web-tool for wiring the Internet of Things)
    cd banana-nodered
    ./install_nodeRed.sh 
    cd .
    
Raspberry Pi 3:

    Install the raspian-light image on a SD-Card and start the Raspberry Pi 3

    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    cd smart-sarah-master/armhf/edge/
    sudo su
    ./edge_install_script.sh

Orange Pi zero:

    Install Armbian Linux on a sd-card:
    https://dl.armbian.com/orangepizero/Debian_jessie_default.7z
    #login as root pw:1234
    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    #6loWPAN router for IEEE 802.15.4 with tunslip6
    cd smart-sarah-master/armhf/edge
    nano system/boarder-router.service

    -ExecStart=/usr/sbin/tunslip6 -B 38400 -L -s ttyUSB0 fd00::1/64
    +ExecStart=/usr/sbin/tunslip6 -B 38400 -L -s ttyS1 fd00::1/64

    ./edge_install_script.sh

Supported Hardware
------------------

    A20-OLinuXIno-LIME2   Status: supported (beta)
    Banana Pro            Status: fully supported (stable)
    Banana Pi M1          Status: fully supported (stable)
    Banana Pi M1+         Status: fully supported (stable)
    Banana Pi R1 (router) Status: supported (stable)
    Banana Pi M2          Status: supported (beta)
    Orange Pi             Status: supported (beta)
    orange Pi zero        Status: supported (beta)
    Raspberry Pi 3        Status: supported (beta)
    
Planned
-------

    Olimex A10-Lime
    Olimex A20-Lime

