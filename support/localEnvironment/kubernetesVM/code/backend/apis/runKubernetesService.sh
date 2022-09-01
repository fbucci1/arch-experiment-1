
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

until nc -w 300 -z $SVCHOST $SVCPORT; do
    sleep 5
done

echo "Ready"

curl $SVCHOST:$SVCPORT
