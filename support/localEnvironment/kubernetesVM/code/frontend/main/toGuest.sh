mkdir -p /home/vagrant/workspace

while [[ true ]]
do
    rsync -rav /vagrant/code/frontend/main /home/vagrant/workspace | grep main
    sleep 1
done