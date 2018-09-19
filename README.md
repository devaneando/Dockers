# Dockers

Some general purpose dockers

## Apache-php

These are images with Apache2.4 and PHP (the chosen version will depend on the `Dockerfile`).

## How to publish an image to Docker hub

As an example, how to push the `apache-php:7.2` image to [devaneando/apache-php](https://hub.docker.com/r/devaneando/apache-php/).

```bash
$ docker build -t apache-php:7.2

$ docker login --username=devaneando

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
apache-php          7.2                 76f182182fd9        About a minute ago   259MB
ubuntu              18.04               735f80812f90        2 weeks ago          83.5MB

$ docker tag 76f182182fd9 devaneando/apache-php:7.2

$ docker push devaneando/apache-php
```
