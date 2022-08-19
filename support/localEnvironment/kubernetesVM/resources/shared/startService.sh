#!/bin/bash

SERVICE=$1

if [ ! -f "/home/vagrant/resources/$SERVICE/installed" ]
then
    echo "============== Installing $SERVICE in order to be able to start it."
    /home/vagrant/resources/shared/installService.sh $SERVICE
    echo "============== $SERVICE installed, now we can start it."
fi

echo "============== Starting $SERVICE"
/home/vagrant/resources/$SERVICE/start.sh
echo "============== $SERVICE started"
