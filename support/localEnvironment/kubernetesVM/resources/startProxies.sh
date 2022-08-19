#!/bin/bash
#set -x #echo on

startProxyForServicePort() {
    serviceNamespace=$1
    serviceName=$2
    servicePort=$3
    proxyPort=$4
    echo "Waiting for service to be ready :" $serviceNamespace service/$serviceName $servicePort
    host=$(microk8s kubectl get -n $serviceNamespace service/$serviceName -o=jsonpath='{.spec.clusterIP}')
    while ! nc -z $host $servicePort 
    do
        # Shows pods not started
        microk8s kubectl get pod -n $serviceNamespace|grep $serviceName
        microk8s kubectl describe pod -n $serviceNamespace|grep Warning
        # Forces those not started to restart
        listaPods=$(kubectl get pod -n $serviceNamespace|grep 0/|awk '{print $1}')
        for pod in $listaPods
        do
            microk8s kubectl get pod $pod -n $serviceNamespace -o yaml | microk8s kubectl replace --force -f -
        done
        # Waits and retries
        sleep 10
        host=$(microk8s kubectl get -n $serviceNamespace service/$serviceName -o=jsonpath='{.spec.clusterIP}')
        echo "Waiting for service to be ready :" $serviceNamespace service/$serviceName $servicePort
    done
    echo "Service is ready. Opeining proxy in port localhost:$proxyPort"
    microk8s kubectl port-forward -n $serviceNamespace service/$serviceName $proxyPort:$servicePort --address="0.0.0.0" &
}

echo "Starting proxies..."

sleep 5

startProxyForServicePort kube-system kubernetes-dashboard 443 20000
echo "Started dashboard proxy..."

echo "Dashboard available in host machine: https://localhost:10000/"
echo "Token is: " `microk8s kubectl create token -n kube-system default --duration=8544h`

echo "Enjoy now..."
