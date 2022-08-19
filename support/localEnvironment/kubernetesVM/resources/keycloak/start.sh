#!/bin/bash

#KC_KEYCLOAK_ADMIN=admin
#KC_KEYCLOAK_ADMIN_PASSWORD=1234

#KEYCLOAK_ADMIN=admin
#KEYCLOAK_ADMIN_PASSWORD=1234

#KC_ADMIN=admin
#KC_ADMIN_PASSWORD=1234

sudo /opt/keycloak/bin/kc.sh start-dev --http-port 21001 &
