#!/bin/bash

echo "-------------- Install npm"
/home/vagrant/resources/shared/installService.sh npm
echo "-------------- Install Anglular CLI"
sudo npm install -g @angular/cli
