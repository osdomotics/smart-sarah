smart-sarah
===========

System Service installer for Smart-SARAH Home-Automation System

Services
--------

    Ajenti (The admin panel your servers deserve)
    6loWPAN router for IEEE 802.15.4
    wifiap (banana-pro as wlan access point)
    OMD (Open Monitoring Distribution)
    Linwebknx (Home Automation Software)
    Node-Red (A visual web-tool for wiring the Internet of Things)
    Meteor-js deploy server (run a meteor app on a banana pi/pro)    

Requirements
------------

Banana-Pro:

Bananian Linux 16.04 released - 2016-04-23

Go and download the latest version from the official site https://www.bananian.org/download Flash the image file to your SD card following the instruction on that website, that has to be at least 2GB.


Quickstart
----------
banana-pro:

    login as root
    apt-get install git
    git clone https://github.com/osdomotics/smart-sarah.git

Raspberry Pi 3:

    wget https://github.com/osdomotics/smart-sarah/archive/master.zip
    unzip master.zip
    cd smart-sarah-master/raspi-edge/
    sudo su
    ./edge_install_script.sh

Supported Hardware
------------------

    Raspberry Pi 3
    Banana pi
    Banana pro


Planned
-------

    Olimex A10-Lime
    Olimex A20-Lime
    Olimex A20-Lime2
