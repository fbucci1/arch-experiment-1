#!/bin/bash
ts0=$(date +%s%N)
echo "About to destroy Kubernetes VM!"

vagrant destroy

ts1=$(date +%s%N)
echo Time elapsed: $((($ts1 - $ts0)/1000000)) msecs.
