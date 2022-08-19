#!/bin/bash

echo "-------------- Setting up permissions for vagrant user -------------------------"
sudo usermod -a -G microk8s vagrant
echo "-------------- Moving .kube folder to vagrant user -----------------------------"
if [ ! -d "/home/vagrant/.kube" ]
then
    mkdir /home/vagrant/.kube
fi
sudo chown -f -R vagrant /home/vagrant/.kube
echo "-------------- Installing microk8s ---------------------------------------------"
sudo snap install microk8s --classic
echo "-------------- Installing Docker -----------------------------------------------"
sudo snap install docker
echo "-------------- Starting microk8s -----------------------------------------------"
sudo microk8s.status --wait-ready
echo "-------------- Enabling microk8s services --------------------------------------"
sudo microk8s.enable dns registry helm3
echo "-------------- Defining aliases for vagrant user -------------------------------"
echo "alias kubectl='microk8s.kubectl'" >> /home/vagrant/.bash_aliases
echo "alias helm='microk8s.helm3'" >> /home/vagrant/.bash_aliases
source /home/vagrant/.bash_aliases
echo "-------------- Reloading user --------------------------------------------------"
sudo newgrp microk8s &
echo "-------------- Finished microk8s -----------------------------------------------"
