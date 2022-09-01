#!/bin/bash

echo "-------------- Installing microk8s application"
sudo snap install microk8s --classic
echo "-------------- Installing Docker"
sudo snap install docker
echo "-------------- Starting microk8s"
sudo microk8s.status --wait-ready
sudo microk8s enable registry
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

echo "Configuring Microk8s to use its repository"
#REGHOST=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.clusterIP}")
#REGPORT=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.ports[0].port}")
REGHOST=localhost
REGPORT=5001
sudo mkdir -p /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT
sudo touch /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml
printf "server = \"http://$REGHOST:$REGPORT\"\n[host.\"http://$REGHOST:$REGPORT\"]\ncapabilities = [\"pull\", \"resolve\"]\n" | sudo tee /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml

echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  IMPORTANT  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!                                                                                                !!"
echo "!! Close the session (exit) and log in again (vagrant ssh) in order for microk8s commands to work !!"
echo "!!                                                                                                !!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""


