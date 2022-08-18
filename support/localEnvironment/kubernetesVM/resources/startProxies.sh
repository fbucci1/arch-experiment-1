echo "Starting proxies..."

nc -z `microk8s kubectl get -n kube-system service/kubernetes-dashboard -o=jsonpath='{.spec.clusterIP}'` 443
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 20000:443 --address="0.0.0.0" &
echo "Started dashboard proxy..."

echo "Dashboard available in host machine: https://localhost:10000/"
echo "Token is: " `microk8s kubectl create token -n kube-system default --duration=8544h`

echo "Enjoy now..."
