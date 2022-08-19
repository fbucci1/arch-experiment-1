#!/bin/bash

# See releases in https://github.com/keycloak/keycloak
# Resources: https://www.altenburger.io/posts/install_keycloak/

echo "-------------- Install JDK"
/home/vagrant/resources/shared/installService.sh jdk
echo "-------------- Downloading installer"
URL=https://github.com/keycloak/keycloak/releases/download/19.0.1/keycloak-19.0.1.tar.gz
NAME=keycloak-19.0.1
curl -L -o $NAME.tar.gz $URL
echo "-------------- Unzipping installer"
sudo tar -x -f $NAME.tar.gz
rm $NAME.tar.gz
echo "-------------- Copying application to /opt folder"
sudo mkdir -p /opt/keycloak
sudo mv $NAME/* /opt/keycloak
echo "-------------- Creating user and group"
sudo chown -R vagrant /opt/keycloak
echo "-------------- Set up service"

