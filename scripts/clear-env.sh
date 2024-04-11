#!/bin/bash 

docker container stop docker-tc
docker container stop rabbitmq
docker network remove rabbitmq-perf-net