#!/bin/bash 

docker network remove rabbitmq-perf-net
docker container stop docker-tc
docker container stop rabbitmq
