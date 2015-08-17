#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt..."
	read -p "apt-get update (y/n)? " update
	case "$update" in
				y)	sudo apt-get -y update
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
	read -p "apt-get upgrade (y/n)? " upgrade
	case "$upgrade" in
				y)	sudo apt-get -y upgrade
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

nodejs()
{
	read -p "\nDo you want to install Node.js (y/n)? " nodejs
	case "$nodejs" in
				y)	echo "\nInstall Node.js..."
                                        sudo curl -sL https://deb.nodesource.com/setup | bash -
                                        sudo apt-get install -y build-essential python-dev nodejs
					node -v
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

nodeRed()
{
#	echo "\nExpand Filesystem..."
	read -p "\nInstall Node-Red (y/n)? " nodeRed
	case "$nodeRed" in
				y)	echo "\nInstall Node-Red..."
				        sudo npm cache clean
					echo "\nInstall COAP- Cli..."
					sudo npm install coap-cli -g
					sudo npm install redis -g
					sudo npm install mongodb -g					sudo npm install -g node-red
					echo "\nInstall COAP- Node-Red..."
					sudo npm install -g node-red-contrib-coap
					echo "\n Install Start Script"
					sudo npm install -g pm2
                                        sudo pm2 start /usr/bin/node-red --node-args="--max-old-space-size=128" -- -v
                                        sudo pm2 save
                                        sudo pm2 startup
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}




read -p "Do you want to install Node-Red (y/n)? " response

case "$response" in
	y) 	echo "\nInstall Node-Red-Package..."
		
		dir1=`pwd`
        #echo "dir1= " $dir1
        dir2=`dirname $0`
        #echo "dir2= " $dir2

        cd $dir1
        cd $dir2
        #pwd

		updateApt
		upgradeApt
		nodejs
		nodeRed
		
		sudo node red.js
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
