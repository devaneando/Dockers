#!/bin/bash
reset

sudo docker build \
    --force-rm \
    --tag apache-php:7.2 \
    .
