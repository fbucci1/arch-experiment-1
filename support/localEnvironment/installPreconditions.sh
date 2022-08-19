#!/bin/bash
ts0=$(date +%s%N)
echo "Now, I will install preconditions for the rest of the software needed. It is $(date +"%T")"

#If it does not work, download from https://www.virtualbox.org/wiki/Downloads
echo "Installing VirtualBox"
winget install Oracle.VirtualBox

#If it does not work, download from https://www.vagrantup.com/downloads Latest, Windows, 686
echo "Installing Vagrant"
curl https://releases.hashicorp.com/vagrant/2.3.0/vagrant_2.3.0_windows_i686.msi -o tmp_vagrant.msi
start tmp_vagrant.msi
while ! rm tmp_vagrant.msi;
do
   sleep 2
done

ts1=$(date +%s%N)
echo Time elapsed: $((($ts1 - $ts0)/1000000/1000/60)) mins.

