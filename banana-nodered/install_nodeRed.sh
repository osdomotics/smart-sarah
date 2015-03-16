#!/bin/sh
#$Id$

updateApt()
{
	echo "\nUpdate Apt..."
	read -p "apt-get update (j/n)? " update
	case "$update" in
				j)	sudo apt-get -y update
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
	read -p "apt-get upgrade (j/n)? " upgrade
	case "$upgrade" in
				j)	sudo apt-get -y upgrade
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}

nodejs()
{
#	echo "\nInstall Node.js..."
	read -p "\nDo you want to install Node.js (j/n)? " nodejs
	case "$nodejs" in
				j)	echo "\nInstall Node.js..."
                                        sudo curl -sL https://deb.nodesource.com/setup | bash -
                                        sudo apt-get install python nodejs
#					sudo wget http://node-arm.herokuapp.com/node_0.10.36_armhf.deb
#					sudo dpkg -i node_0.10.36_armhf.deb
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
	read -p "\nInstall Node-Red (j/n)? " nodeRed
	case "$nodeRed" in
				j)	echo "\nInstall Node-Red..."
					sudo apt-get install git-core
					git clone https://github.com/node-red/node-red.git
					cd node-red
					echo "\nInstall..."
					sudo npm install
					echo "\nInstall COAP- Node-Red..."
					sudo npm install node-red-contrib-coap
					echo "\nInstall COAP- Cli..."
					sudo npm install coap-cli -g
					echo "\n Install Start Script"
					cd $dir1
					cd $dir2
					pwd
					cd init.d
					echo "\n chmod...."
					sudo chmod a+x node-red
					cd ..
					echo "\n cp...."
					sudo cp init.d/node-red /etc/init.d/node-red
					sudo insserv node-red
					echo "\n check...."
					cd node-red
					;;
				n)	echo "Close..."
					;;
				*)	echo "false input"
					;;
			esac
}




read -p "Do you want to install Node-Red (j/n)? " response

case "$response" in
	j) 	echo "\nInstall Node-Red-Package..."
		
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
