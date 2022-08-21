#!/bin/bash

pkill -9 -f "/opt/keycloak"
pkill -9 -f "kc.sh"
sleep 5

sudo rm -rf /opt/keycloak
