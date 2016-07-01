#!/bin/bash

no_of_nodes=$1
re_check_no='^[0-9]+$'

if ! [[ $no_of_nodes =~ $re_check_no ]] ; then
   echo "error: Must pass number of docker instances to launch as the first argument" >&2; exit 1
fi
echo "Running network create"
sudo docker network create dockersuicidesquad2_default 
echo "Running  compose"
sudo docker-compose up -d --no-recreate
echo "Running scale"
`sudo docker-compose scale node=${no_of_nodes}`

while true; do
    log=`sudo docker events --filter 'image=dockersuicidesquad2_node' --filter 'event=die'  --since=5s --until=0s`
    echo "Checking after every 3 seconds if a contianer has stopped"
    if [ -z "$log" ]; then
        sleep 5
    else 
        echo "Someone is dead, Stopping rest of the containers"
        sudo docker-compose down
        exit 1
    fi
done
