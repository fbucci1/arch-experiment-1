#!/bin/bash

SERVICE=$1

if [ ! -f "/home/vagrant/resources/$SERVICE/installed" ]
then
    echo "==============> Installing $SERVICE"
    /home/vagrant/resources/shared/installService.sh $SERVICE
    echo "==============> $SERVICE installed"
fi

echo "============== Starting $SERVICE"
/home/vagrant/resources/$SERVICE/start.sh
echo "============== $SERVICE started"
