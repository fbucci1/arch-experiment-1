#!/bin/bash
ts0=$(date +%s%N)
echo "Sit comfortably while I create Kubernetes VM for you. It is $(date +"%T")"

vagrant up

ts1=$(date +%s%N)
echo Time elapsed: $((($ts1 - $ts0)/1000000/1000/60)) mins.

vagrant ssh
