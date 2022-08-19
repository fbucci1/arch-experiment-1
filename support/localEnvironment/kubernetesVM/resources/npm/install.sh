#!/bin/bash

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
echo "npm $(npm -v)"
echo "node $(node -v)"
