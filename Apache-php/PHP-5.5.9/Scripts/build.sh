#!/bin/bash
reset

sudo docker build \
    --force-rm \
    --tag apache-php:5.5.9 \
    .
