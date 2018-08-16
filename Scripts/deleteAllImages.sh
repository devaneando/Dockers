#!/bin/bash

reset

read -p "Are you sure you want to delete all images? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then

    containers=$(sudo docker ps -q)
    if [[ ! -z ${containers} ]]; then
        sudo docker kill ${containers}
    fi

    images=$(sudo docker images -q)
    if [[ -z ${images} ]]; then
        echo "There's no image to delete".
        exit 0
    fi

    sudo docker rmi ${images} -f
fi
