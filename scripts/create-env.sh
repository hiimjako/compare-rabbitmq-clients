#!/bin/bash 

docker network create rabbitmq-perf-net
docker run -d --name docker-tc --network host --cap-add NET_ADMIN --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /var/docker-tc:/var/docker-tc lukaszlach/docker-tc

# creating rabbit server
docker run --name rabbitmq --network rabbitmq-perf-net -h rabbitmq -p 5552:5552 -p 15672:15672 -d rabbitmq:3.13.1-management-alpine 
sleep 10
docker exec rabbitmq rabbitmq-plugins enable rabbitmq_stream 
docker exec rabbitmq rabbitmq-plugins enable rabbitmq_management
