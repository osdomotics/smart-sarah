#!/bin/bash
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-debian.sh | sh
# bugfix debian jessie gevent ssl
service ajenti stop
sudo apt-get install python-dev python-greenlet python-gevent python-vte python openssl python-crypto python-appindicator
sudo apt-get install python-setuptools
easy_install -U gevent
service ajenti start