echo "Configuring Microk8s to use its repository"

REGHOST=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.clusterIP}")
REGPORT=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.ports[0].port}")

sudo mkdir -p /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT
sudo touch /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml
sudo bash -c 'printf "server = \"http://$REGHOST:$REGPORT\"\n" > /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml'
sudo bash -c 'printf "[host.\"http://$REGHOST:$REGPORT\"]\n" >> /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml'
sudo bash -c 'printf "capabilities = [\"pull\", \"resolve\"]\n" >> /var/snap/microk8s/current/args/certs.d/$REGHOST:$REGPORT/hosts.toml'

echo "Create service"

microk8s kubectl delete -f resources/service.yaml
microk8s kubectl create -f resources/service.yaml

#microk8s kubectl describe pods/apis-pod
microk8s kubectl get pods -n default
microk8s kubectl get service -n default

echo "Starting..."

SVCHOST=$(microk8s kubectl get services apis-service -n default -o jsonpath="{.spec.clusterIP}")
SVCPORT=$(microk8s kubectl get services apis-service -n default -o jsonpath="{.spec.ports[0].port}")

echo "Waiting for service in $SVCHOST:$SVCPORT"

nc -w 300 -z $SVCHOST $SVCPORT

echo "Ready"

curl $SVCHOST:$SVCPORT
