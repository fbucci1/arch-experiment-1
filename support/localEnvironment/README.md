# Local Environment

## Installation

### Install Git-bash

Download Git installer [here](https://gitforwindows.org/) and run it.
   Install using using default settings (change to use Notepad++ for editing files).

### Install GitHub Desktop

Download GitHub Desktop installer [here](https://desktop.github.com/) and run it.

Open SourceTree and clone this repository to a local folder in your PC.
We will call it the $ROOTFOLDER, e.g. C:\soft\projects\github-repos\example

### Install Sprint Tool Suite

https://jdk.java.net/18/

https://spring.io/tools

cd c:\soft
jdk-18.0.2.1\bin\java -jar spring-tool-suite-4-4.15.3.RELEASE-e4.24.0-win32.win32.x86_64.self-extracting.jar

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
* [ng serve](http://localhost:8088)

### The VM is configured to forward the following ports:

*VM Port forwarding for ClusterIP (requires kubectl port-forward)*
* host: 10000, guest: 20000, Purpose: Dashboard (HTTPS)
* host: 10001, guest: 20001, Purpose: Grafana (HTTP)
* host: 10002, guest: 20002, Purpose: Available
* host: 10003, guest: 20003, Purpose: Available
* host: 10004, guest: 20004, Purpose: Available
*#VM Port forwarding for NodePorts (does not require kubectl port-forward)*
* host: 8088, guest: 4200, Purpose: Frontend: main - ng serve (HTTP)
* host: 11000, guest: 30777, Purpose: Portainer (HTTP)
* host: 11001, guest: 21001, Purpose: Keycloak (HTTP)

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

## Keycloak
Sample request for generating a JWT form the guest machine:

curl -X POST -d "client_id=myclient" -d "client_secret=000000-000000-000000-000000" -d "grant_type=password" -d "username=testuser" -d "password=1234" http://localhost:21001/realms/demorealm/protocol/openid-connect/token
