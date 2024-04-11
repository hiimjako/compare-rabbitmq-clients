#!/bin/bash 

docker container stop docker-tc
docker container rm docker-tc
docker container stop rabbitmq
docker container rm rabbitmq
docker network remove rabbitmq-perf-net