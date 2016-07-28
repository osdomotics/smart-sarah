#!/bin/sh
#$Id$

updateApt()
{
	apt-get -y update
}

upgradeApt()
{
	apt-get -y upgrade
}

nodejs()
{

        apt-get -y install nodejs npm
        npm cache clean -f
        npm install -g n
        n stable
        npm install -g npm@2.x
}

nodeRed()
{
					echo "\nInstall..."
				        npm cache clean
					echo "\nInstall COAP- Cli..."
					npm install coap-cli -g
					npm install redis -g
					npm install mongodb -g
                                        echo "\nInstall Node-Red..."
					npm install -g node-red
					echo "\nInstall COAP- Node-Red..."
					npm install -g node-red-contrib-coap
					echo "\n Install Start Script"
					npm install -g pm2
                                        pm2 start /usr/bin/node-red --node-args="--max-old-space-size=128" -- -v
                                        pm2 save
                                        pm2 startup
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
		;;
	n)	echo "Close..."
		;;
	*)	echo "false input"
		;;
	
esac
