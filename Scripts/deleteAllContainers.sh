#!/bin/bash

reset

read -p "Are you sure you want to delete all containers? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then

    containers=$(sudo docker ps -q)
    if [[ ! -z ${containers} ]]; then
        sudo docker kill ${containers}
    fi

    containers=$(sudo docker ps -a -q)
    if [[ -z ${containers} ]]; then
        echo "There's no container to delete".
        exit 0
    fi

    sudo docker rm ${containers}
fi
