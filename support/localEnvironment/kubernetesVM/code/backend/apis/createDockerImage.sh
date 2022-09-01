echo "Building application - Creating .jar file"
./mvnw clean install
echo "Creating container image"
buildah bud -f resources/Dockerfile -t apis
echo "Listing images in buildah local repository"
buildah images
echo "Looking for Microk8s registry"
#/vagrant/code/backend/apis$ kubectl get services -A
#NAMESPACE            NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
#container-registry   registry     NodePort    10.152.183.7   <none>        5000:32000/TCP   3m14s
#REGHOST=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.clusterIP}")
#REGPORT=$(microk8s kubectl get services registry -n container-registry -o jsonpath="{.spec.ports[0].port}")
REGHOST=localhost
REGPORT=5001
echo "Publishing image in Microk8s registry $REGHOST:$REGPORT"
buildah push --tls-verify=false apis $REGHOST:$REGPORT/apis
echo "Done"