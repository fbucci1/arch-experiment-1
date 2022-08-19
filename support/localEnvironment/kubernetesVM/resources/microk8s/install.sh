#!/bin/bash

echo "-------------- Installing microk8s application"
sudo snap install microk8s --classic
echo "-------------- Installing Docker"
sudo snap install docker
echo "-------------- Starting microk8s"
sudo microk8s.status --wait-ready
echo "-------------- Enabling microk8s services"
sudo microk8s.enable dns registry helm3
echo "-------------- Defining shortcuts for commands"
echo "alias kubectl='microk8s.kubectl'" >> /home/vagrant/.bash_aliases
echo "alias helm='microk8s.helm3'" >> /home/vagrant/.bash_aliases
source /home/vagrant/.bash_aliases
echo "-------------- Setting up permissions for vagrant user"
sudo usermod -a -G microk8s vagrant
echo "-------------- Moving .kube folder to vagrant user"
mkdir -p /home/vagrant/.kube
sudo chown -f -R vagrant /home/vagrant/.kube
echo "-------------- Reloading user"
newgrp microk8s &
echo "-------------- Finished microk8s"

echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  IMPORTANT  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!                                                                                                !!"
echo "!! Close the session (exit) and log in again (vagrant ssh) in order for microk8s commands to work !!"
echo "!!                                                                                                !!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""


