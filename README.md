smart-sarah
===========

System Service installer for Smart-SARAH Home-Automation System

Services
--------

    6loWPAN router for IEEE 802.15.4
    wifiap (banana-pro as wlan access point)
    OMD (Open Monitoring Distribution)
    Linwebknx (Home Automation Software)
    Node-Red (A visual web-tool for wiring the Internet of Things)
    Meteor-js deploy server (run a meteor app on a banana pi/pro)    

Requirements
------------

banana-pro:

Go and download the latest version from the official site https://www.bananian.org/download Flash the image file to your SD card following the instruction on that website, that has to be at least 2GB.

Update to debian jessie:

    1.) sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
    2.) apt-get update
    3.) apt-get upgrade
    4.) apt-get dist-upgrade
    5.) shutdown -r now


Quickstart
----------

banana-pro:

    login as root
    apt-get install git
    git clone https://github.com/osdomotics/smart-sarah.git
  

Supported Hardware
------------------

    Raspberry pi 2
    Banana pi
    Banana pro


Planned
-------

    Olimex A10-Lime
    Olimex A20-Lime
    Olimex A20-Lime2
