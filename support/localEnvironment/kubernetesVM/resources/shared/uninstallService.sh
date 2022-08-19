#!/bin/bash

SERVICE=$1

if [ ! -f "/home/vagrant/resources/$SERVICE/installed" ]
then
    echo "* Service $SERVICE was not installed."
    exit 0
fi

echo "============== Uninstalling $SERVICE"
/home/vagrant/resources/$SERVICE/uninstall.sh
echo "============== $SERVICE uninstalled"

rm /home/vagrant/resources/$SERVICE/installed
