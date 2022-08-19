#!/bin/bash

sudo snap install microk8s --classic
echo "-------------- Installing Docker -----------------------------------------------"
sudo snap install docker
echo "-------------- Starting MicroK8s -----------------------------------------------"
sudo microk8s.status --wait-ready
echo "-------------- Enabling microK8s services --------------------------------------"
sudo microk8s.enable dns registry helm3
echo "-------------- Setting up permissions for vagrant user -------------------------"
sudo usermod -a -G microk8s vagrant
newgrp microk8s
#echo "-------------- Moving .kube folder to vagrant user -----------------------------"
#mv ~/.kube /home/vagrant/.kube
#chown -f -R vagrant:vagrant /home/vagrant/.kube
echo "-------------- Defining aliases for vagrant user -------------------------------"
echo "alias kubectl='microk8s.kubectl'" >> /home/vagrant/.bash_aliases
echo "alias helm='microk8s.helm3'" >> /home/vagrant/.bash_aliases
chown vagrant:vagrant /home/vagrant/.bash_aliases
source /home/vagrant/.bash_aliases
