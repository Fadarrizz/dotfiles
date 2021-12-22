#!/bin/bash

docker kill $(docker ps -q)
docker rm $(docker ps -aq)

if [ "$1" == "-a" ]
then
    docker image prune -af
    docker volume prune -f
    docker builder prune -af
    docker system prune --volumes -af
fi
