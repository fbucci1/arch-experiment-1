#!/bin/bash

rsync -ravu --exclude='node_modules' --exclude='.angular' --exclude='.vscode' /home/vagrant/workspace/main /vagrant/code/frontend