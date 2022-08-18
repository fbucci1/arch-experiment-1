#!/bin/bash
ts0=$(date +%s%N)
echo "Ensuring Kubernetes VM is created, up and then connect to it via SSH"

vagrant up

ts1=$(date +%s%N)
echo Time elapsed: $((($ts1 - $ts0)/1000000/1000/60)) mins.

vagrant ssh
