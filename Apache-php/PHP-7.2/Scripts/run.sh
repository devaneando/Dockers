#!/bin/bash
reset

sudo docker container run \
    --publish 80:80 \
    --publish 443:443 \
    --rm \
    apache-php:7.2
