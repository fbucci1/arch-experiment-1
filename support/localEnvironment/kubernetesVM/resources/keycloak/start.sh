#!/bin/bash

export KEYCLOAK_ADMIN=admin
export KEYCLOAK_ADMIN_PASSWORD=1234

/opt/keycloak/bin/kc.sh start-dev --http-port 21001 &
