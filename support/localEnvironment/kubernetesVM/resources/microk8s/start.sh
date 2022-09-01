#!/bin/bash

# MicroK8s starts automatically

/home/vagrant/resources/shared/startProxyForServicePort.sh container-registry registry 5000 5001

echo "==> Registry available in VM: http://localhost:5001/"

