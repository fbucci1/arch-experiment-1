#!/bin/bash
ts0=$(date +%s%N)
echo "About to destroy Kubernetes VM!. It is $(date +"%T")"

vagrant destroy -f

ts1=$(date +%s%N)
echo Time elapsed: $((($ts1 - $ts0)/1000000/1000/60)) mins.
