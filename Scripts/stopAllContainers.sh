#!/bin/bash

reset

read -p "Are you sure you want to stop all containers? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then

    containers=$(sudo docker ps -q)
    if [[ -z ${containers} ]]; then
        echo "There's no container to stop".
        exit 0
    fi

    sudo docker kill ${containers}
fi
