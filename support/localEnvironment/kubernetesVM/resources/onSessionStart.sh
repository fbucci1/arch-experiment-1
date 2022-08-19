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
            FEXPECTED=$( [ "$FEXPECTED" == "true" ] && echo "true" || echo "false" )
            if [[ "$FEXPECTED" == "true" ]] # Not empty
            then
                #echo "Starting $FSERVICE"
                /home/vagrant/resources/shared/startService.sh $FSERVICE
            fi
        fi
    fi
done

echo "-------------- Services started ------------------------------------------------"



