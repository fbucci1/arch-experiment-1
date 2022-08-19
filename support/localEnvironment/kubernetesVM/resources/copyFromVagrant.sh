#!/bin/bash

echo "-------------- Copying resources from host machine -----------------------------"

cp -R /vagrant/resources /home/vagrant

find /home/vagrant/resources -name "*.sh" -exec chmod +x {} \;

echo "-------------- Done ------------------------------------------------------------"

