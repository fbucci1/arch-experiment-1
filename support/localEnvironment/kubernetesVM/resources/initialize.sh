#!/bin/bash

echo "-------------- Initializing  ------------------------------------------------"
echo "-------------- Installing MicroK8s ------------------------------------------"
snap install microk8s --classic
echo "-------------- Installing Docker --------------------------------------------"
snap install docker
echo "-------------- Starting microK8s --------------------------------------------"
microk8s.status --wait-ready
echo "-------------- Enabling microK8s services: Dashboard-------------------------"
microk8s.enable dns registry helm3
microk8s.enable dashboard &
echo "-------------- Enabling microK8s services: Portainer ------------------------"
microk8s.enable community
microk8s.enable portainer &
echo "-------------- Enabling microK8s services: Prometheus ------------------------"
microk8s.enable prometheus &
echo "-------------- Setting up permissions for vagrant user ----------------------"
usermod -a -G microk8s vagrant
newgrp microk8s
echo "-------------- Moving .kube folder to vagrant user --------------------------"
mv ~/.kube /home/vagrant/.kube
chown -f -R vagrant:vagrant /home/vagrant/.kube
echo "-------------- Defining aliases for vagrant user ----------------------------"
echo "alias kubectl='microk8s.kubectl'" >> /home/vagrant/.bash_aliases
echo "alias helm='microk8s.helm3'" >> /home/vagrant/.bash_aliases
chown vagrant:vagrant /home/vagrant/.bash_aliases
source /home/vagrant/.bash_aliases
echo "-------------- Enabling proxies to start ------------------------------------"
mv /home/vagrant/resources/startProxies.sh /home/vagrant/startProxies.sh
chmod +x /home/vagrant/startProxies.sh
echo "./startProxies.sh &" >> /home/vagrant/.bashrc
echo "-------------- We should be ready now ---------------------------------------"
