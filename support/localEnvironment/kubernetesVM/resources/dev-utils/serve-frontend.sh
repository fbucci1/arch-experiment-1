#!/bin/bash
/vagrant/code/frontend/main/toGuest.sh &

sleep 5
/vagrant/code/frontend/main/ng-serve.sh &
