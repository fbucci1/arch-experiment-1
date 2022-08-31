#!/bin/bash

# Ubuntu 20.10 and newer
sudo apt-get -y update
sudo apt-get -y install buildah

sudo bash -c 'printf "[registries.search]\nregistries = [\"docker.io\"]\n" > /etc/containers/registries.conf'


