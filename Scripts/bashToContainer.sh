#!/bin/bash

reset

if [[ -z $1 ]]; then
    echo "I need the container Id"
    exit 1
fi

sudo docker exec -i -t ${1} /bin/bash
