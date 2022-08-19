#!/bin/bash

/home/vagrant/resources/shared/startProxyForServicePort.sh kube-system kubernetes-dashboard 443 20000

echo "==> Dashboard available in host machine: https://localhost:10000/"
echo "==> Token is: " `microk8s kubectl create token -n kube-system default --duration=8544h`

