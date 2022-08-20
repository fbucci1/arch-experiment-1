#!/bin/bash
/vagrant/code/frontend/main/toGuest.sh &

sleep 10
npm install

/vagrant/code/frontend/main/ng-serve.sh &
