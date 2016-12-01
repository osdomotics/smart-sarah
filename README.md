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

Banana-Pro:

Bananian Linux 16.04 released - 2016-04-23

Go and download the latest version from the official site https://www.bananian.org/download Flash the image file to your SD card following the instruction on that website, that has to be at least 2GB.


Quickstart
----------
banana-pro:

    #login as root
    apt-get install git
    git clone https://github.com/osdomotics/smart-sarah.git
    #6loWPAN router for IEEE 802.15.4
    cd smart-sarah/banana-edge/
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

Raspberry Pi 3:

    Install the raspian-light image on a SD-Card and start the Raspberry Pi 3

    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    cd smart-sarah-master/raspi-edge/
    sudo su
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
    Raspberry Pi 3        Status: supported (beta)
    
Planned
-------

    Olimex A10-Lime
    Olimex A20-Lime

