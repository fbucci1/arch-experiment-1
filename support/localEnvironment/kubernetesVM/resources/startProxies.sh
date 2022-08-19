#!/bin/bash
#set -x #echo on

startProxyForServicePort() {
    serviceNamespace=$1
    serviceName=$2
    servicePort=$3
    proxyPort=$4
    echo "Waiting for service to be ready :" $serviceNamespace service/$serviceName $servicePort
    # Looks for ClusterIP of the service
    host=""
    while [ "$host" == "" ]
    do
        host=$(microk8s kubectl get -n $serviceNamespace service/$serviceName -o=jsonpath='{.spec.clusterIP}')
        if [ "$host" == "" ]
        then
            sleep 5
            echo "   Retry looking up the ClusterIP..."
        fi
    done
    # Waits for service to be listening for connections in the expected port
    ok=0
    while [ "$ok" != "1" ]
    do
        # Checks and retries if not available yet
        for i in {1..6}
        do
            nc -z $host $servicePort && ok="1" && break || sleep 10
        done
        # If not available after n retries, refreshes the pods not ready yet
        if [ "$ok" != "1" ]
        then
            # Shows pods not started in the same namespace
            microk8s kubectl get pod -n $serviceNamespace|grep 0/
            microk8s kubectl describe pod -n $serviceNamespace|grep Warning
            # Forces those not started in the same namespace to restart
            echo "   Forcing pods not started to restart..."
            listaPods=$(kubectl get pod -n $serviceNamespace|grep 0/|awk '{print $1}')
            for pod in $listaPods
            do
                microk8s kubectl get pod $pod -n $serviceNamespace -o yaml | microk8s kubectl replace --force -f -
            done
        fi
    done
    echo "   Service is ready. Opeining proxy in port localhost:$proxyPort -> $serviceName:$servicePort"
    microk8s kubectl port-forward -n $serviceNamespace service/$serviceName $proxyPort:$servicePort --address="0.0.0.0" &
}

echo "Starting proxies..."

startProxyForServicePort kube-system kubernetes-dashboard 443 20000

startProxyForServicePort monitoring grafana 3000 20001

echo "==> Dashboard available in host machine: https://localhost:10000/"
echo "==> Token is: " `microk8s kubectl create token -n kube-system default --duration=8544h`

