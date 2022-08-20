# Local Environment

## Installation

### Install Git-bash

Download Git installer [here](https://gitforwindows.org/) and run it.
   Install using using default settings (change to use Notepad++ for editing files).

### Install SourceTree

Download SourceTree installer [here](https://www.sourcetreeapp.com/) and run it.

Open SourceTree and clone this repository to a local folder in your PC.
We will call it the $ROOTFOLDER, e.g. C:\soft\projects\github-repos\example

### Install base software

Run the following commands in your PC using Git bash:
```bash
ROOTFOLDER=/c/soft/projects/github-repos/example
cd $ROOTFOLDER/support/localEnvironment
./installPreconditions.sh
```

### Create Kubernetes VM

Run the following commands in your PC:
```bash
cd $ROOTFOLDERsupport/localEnvironment/kubernetesVM
./create.sh
```

### Check resources

Now, you should be able to view the following resources using a browser in your PC:
* [Dashboard](https://localhost:10000)
* [Grafana](http://localhost:10001)
* [Portainer](http://localhost:11000)
* [Keycloak](http://localhost:11001)
* [ng serve](http://localhost:11002)

### The VM is configured to forward the following ports:

*VM Port forwarding for ClusterIP (requires kubectl port-forward)*
* host: 10000, guest: 20000, Purpose: Dashboard (HTTPS)
* host: 10001, guest: 20001, Purpose: Grafana (HTTP)
* host: 10002, guest: 20002, Purpose: Available
* host: 10003, guest: 20003, Purpose: Available
* host: 10004, guest: 20004, Purpose: Available
*#VM Port forwarding for NodePorts (does not require kubectl port-forward)*
* host: 11000, guest: 30777, Purpose: Portainer (HTTP)
* host: 11001, guest: 21001, Purpose: Keycloak (HTTP)
* host: 11002, guest: 4200, Purpose: ng serve (HTTP)

### Troubleshooting

* If Portainer has expired, you need to restart it in order to access the console. To restart Portainer, run the following in vagrant ssh:
```bash
kubectl rollout restart deployment portainer -n portainer
```

* To run commands in the host machine, you need to use vagrant ssh, with the following command:
```bash
cd $ROOTFOLDERsupport/localEnvironment/kubernetesVM
vagrant ssh
```



