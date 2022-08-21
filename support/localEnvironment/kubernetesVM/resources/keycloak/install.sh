#!/bin/bash

# See releases in https://github.com/keycloak/keycloak
# Resources: https://www.altenburger.io/posts/install_keycloak/

echo "-------------- Install JDK"
/home/vagrant/resources/shared/installService.sh jdk
echo "-------------- Downloading installer"
URL=https://github.com/keycloak/keycloak/releases/download/19.0.1/keycloak-19.0.1.tar.gz
NAME=keycloak-19.0.1
curl -L -o $NAME.tar.gz $URL
echo "-------------- Unzipping installer"
sudo tar -x -f $NAME.tar.gz
rm $NAME.tar.gz
echo "-------------- Copying application to /opt folder"
sudo mkdir -p /opt/keycloak
sudo mv $NAME/* /opt/keycloak
sudo rm -rf $NAME
echo "-------------- Creating user and group"
sudo chown -R vagrant /opt/keycloak
echo "-------------- Starting service"
servicePort=21001
export KEYCLOAK_ADMIN=admin
export KEYCLOAK_ADMIN_PASSWORD=1234
/opt/keycloak/bin/kc.sh start-dev --http-port $servicePort &
echo "-------------- Wainting for service to start"
ok=0
while [ "$ok" != "1" ]
do
    nc -z localhost $servicePort && ok="1" && break || sleep 10
done
echo "-------------- Setting up configutration"
cd /opt/keycloak/bin
./kcadm.sh config credentials --server http://localhost:21001 --realm master --client admin-cli --user $KEYCLOAK_ADMIN --password=$KEYCLOAK_ADMIN_PASSWORD
REALMNAME=demorealm
CLIENTSECRET=000000-000000-000000-000000
REALMID=$(./kcadm.sh create realms -s realm=$REALMNAME -s enabled=true -i)
CLIENTID=$(./kcadm.sh create clients -r $REALMNAME -s clientId=myclient -s enabled=true -s clientAuthenticatorType=client-secret -s secret=$CLIENTSECRET -s directAccessGrantsEnabled=true -s 'redirectUris=["http://localhost:8088/*"]' -i)
#./kcadm.sh get clients/$CLIENTID/installation/providers/keycloak-oidc-keycloak-json
./kcadm.sh create roles -r $REALMNAME -s name=regularUserRole -s 'description=Regular user with limited set of permissions'
./kcadm.sh create clients/$CLIENTID/roles -r $REALMNAME -s name=editor -s 'description=Editor can edit, and publish any article'
USERID=$(./kcadm.sh create users -r $REALMNAME -s username=testuser -s enabled=true -i)
./kcadm.sh update users/$USERID/reset-password -r $REALMNAME -s type=password -s value=1234 -s temporary=false -n
./kcadm.sh add-roles --uusername testuser --rolename user -r $REALMNAME
./kcadm.sh add-roles -r $REALMNAME --uusername testuser --cclientid myclient --rolename editor
echo "-------------- "
echo "Now, you can get a JWT with the following request: " curl -X POST -d "client_id=myclient" -d "client_secret=$CLIENTSECRET" -d "grant_type=password" -d "username=testuser" -d "password=1234" http://localhost:21001/realms/demorealm/protocol/openid-connect/token
echo "-------------- Done"
