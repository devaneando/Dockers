# Dockers

Some general purpose dockers

## Apache-php

These are images with Apache2.4 and PHP (the chosen version will depend on the `Dockerfile`).

## Scripts

Here you can find scripts to help manage your images and containers.

- **bashToContainer.sh**: connect to a container's bash
- **deleteAllContainers.sh**: stops and deletes all containers.
- **deleteAllImages.sh**: stops all containers and delete all images.
- **stopAllContainers.sh**: stops all containers.

## How to publish an image to Docker hub

As an example, how to push the `apache-php:7.2` image to [devaneando/apache-php](https://hub.docker.com/r/devaneando/apache-php/).

```bash
$docker login --username=devaneando

$docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
apache-php          7.2                 76f182182fd9        About a minute ago   259MB
ubuntu              18.04               735f80812f90        2 weeks ago          83.5MB

$docker tag 76f182182fd9 devaneando/apache-php:7.2

$docker push devaneando/apache-php
```
