# Local environment management

## Install new services

Edit the expected-status.properties file and set to "installed" the services you want to be installed.

Then, run /home/vagrant/resoruces/update.sh

Installed services are automatically started on VM startup or user session opening.

## Uninstall new services

Edit the expected-status.properties file and set to "not-installed" the services you want to be uninstalled.

Then, run /home/vagrant/resoruces/update.sh

## Useful commands
´´´ bash
~/resources/shared/installService.sh microk8s
~/resources/shared/startService.sh microk8s
~/resources/shared/uninstallService.sh microk8s
´´´

## Useful commands during development
´´´ bash
cd /home/vagrant/resoruces

~/resources/copyResourcesFromHost.sh

~/resources/copyResourcesFromHost.sh && ~/resources/update.sh

~/resources/copyResourcesFromHost.sh && ~/resources/onSessionStart.sh

SVC=webpack

~/resources/copyResourcesFromHost.sh && ~/resources/shared/installService.sh $SVC

~/resources/copyResourcesFromHost.sh && ~/resources/shared/uninstallService.sh $SVC

~/resources/copyResourcesFromHost.sh && ~/resources/shared/uninstallService.sh $SVC && ~/resources/shared/installService.sh $SVC
´´´
