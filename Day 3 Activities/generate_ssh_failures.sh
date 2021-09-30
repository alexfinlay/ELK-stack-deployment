#!/bin/bash

echo "Sending SSH requests..."
echo "Press q to quit."

while true; do

        for server in $(cat hosts.txt); do
                ssh sysadmin@$server
        done

        read -t 0.25 -N 1 input;
        if [[ $input = "q" ]]; then
                echo
                break
        fi
done