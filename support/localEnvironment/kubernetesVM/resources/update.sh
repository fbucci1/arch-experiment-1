#!/bin/bash

echo "-------------- Updating status to match the expected ---------------------------"

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
                #Ensure it is installed
                echo "Installing $FSERVICE"
                /home/vagrant/resources/shared/installService.sh $FSERVICE
            elif [[ "$FEXPECTED" == "not-installed" ]]
            then
                #Ensure it is NOT installed
                echo "Uninstalling $FSERVICE"
                /home/vagrant/resources/shared/uninstallService.sh $FSERVICE
            else
                echo "Not touching $FSERVICE. Expected status: $FEXPECTED"
            fi
        fi
    fi
done

echo "-------------- Updated status finished -----------------------------------------"
