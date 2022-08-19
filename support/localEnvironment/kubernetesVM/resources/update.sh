#!/bin/bash

echo "-------------- Updating status to match the expected ---------------------------"

cat expected-status.properties | while IFS=\= read -r FSERVICE FEXPECTED
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
                #Ensure it is installed
                echo "Installing $FSERVICE"
                /home/vagrant/resources/shared/installService.sh $FSERVICE
            else
                #Ensure it is NOT installed
                echo "Uninstalling $FSERVICE"
                /home/vagrant/resources/shared/uninstallService.sh $FSERVICE
            fi
        fi
    fi
done

echo "-------------- Updated status finished -----------------------------------------"
