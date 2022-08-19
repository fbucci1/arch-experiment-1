#!/bin/bash

echo "-------------- Starting services  ----------------------------------------------"

cat /home/vagrant/resources/expected-status.properties | while IFS=\= read -r FSERVICE FEXPECTED
do
    # Trim values
    FSERVICE=`echo $FSERVICE`
    FEXPECTED=`echo $FEXPECTED`
    # Process line
    if [[ $FSERVICE != \#* ]] # Not a comment
    then
        if [[ ! -z "$FSERVICE" ]] # Not empty
        then
            if [[ "$FEXPECTED" == "installed" ]]
            then
                /home/vagrant/resources/shared/startService.sh $FSERVICE
            fi
        fi
    fi
done

echo "-------------- Services started ------------------------------------------------"



