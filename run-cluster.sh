#!/bin/bash

no_of_nodes=$1
re_check_no='^[0-9]+$'

if ! [[ $no_of_nodes =~ $re_check_no ]] ; then
   echo "error: Must pass number of docker instances to launch as the first argument" >&2; exit 1
fi
sudo docker network create dockersuicidesquad1_default || echo "Error creating network"
`sudo docker-compose scale node=${no_of_nodes}`
sudo docker-compose up &

while true; do
    log=`sudo docker events --filter 'image=dockersuicidesquad1_node' --filter 'event=die' --filter 'event=stop' --since=5s --until=0s`
    echo "Checking after every 3 seconds if a contianer has stopped"
    if [ -z "$log" ]; then
        sleep 5
    else 
        echo "Someone is dead, Stopping rest of the containers"
        sudo docker stop $(sudo docker ps -q --filter ancestor=dockersuicidesquad1_node )
        exit 1
    fi
done
