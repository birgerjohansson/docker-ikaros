# Docker-ikaros
Ikaros over Docker

## Pull from docker hub
docker pull birgerjohansson/ikaros

## Build
docker build -t ikaros:latest github.com/birgerjohansson/docker-ikaros

## Run
docker run -i -t -p 8000:8000 birgerjohansson/ikaros /bin/bash

