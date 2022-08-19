#!/bin/bash

SERVICE=$1

if [ -f /home/vagrant/resources/$SERVICE/installed ]
then
    echo "* Service $SERVICE was already installed."
    exit 0
fi

echo "============== Installing $SERVICE"
/home/vagrant/resources/$SERVICE/install.sh
echo "============== $SERVICE installed"

echo "Installed on `date \"+%Y-%m-%d %H:%M:%S\"`" >> /home/vagrant/resources/$SERVICE/installed
