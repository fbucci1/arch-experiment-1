#!/bin/bash
/vagrant/code/frontend/main/toGuest.sh &

ng completion

sleep 10

cd /vagrant/code/frontend/main
npm install

/vagrant/code/frontend/main/ng-serve.sh &
