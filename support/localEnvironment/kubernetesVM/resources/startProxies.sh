startProxtForServicePort() {
    serviceNamespace=$1
    serviceName=$2
    servicePort=$3
    proxyPort=$4
    echo "Waiting for service to be ready :" $serviceNamespace service/$serviceName $servicePort
    host=$(microk8s kubectl get -n $serviceNamespace service/$serviceName -o=jsonpath='{.spec.clusterIP}')
    while ! nc -z $host $servicePort ; do sleep 1 ; done
    echo "Service is ready. Opeining proxy in port localhost:$proxyPort"
    microk8s kubectl port-forward -n $serviceNamespace service/$serviceName $proxyPort:$servicePort --address="0.0.0.0" &
}

echo "Starting proxies..."

startProxtForServicePort kube-system kubernetes-dashboard 443 20000
echo "Started dashboard proxy..."

echo "Dashboard available in host machine: https://localhost:10000/"
echo "Token is: " `microk8s kubectl create token -n kube-system default --duration=8544h`

echo "Enjoy now..."
