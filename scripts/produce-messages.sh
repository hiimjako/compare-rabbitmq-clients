#!/bin/bash 

docker run -it --rm \
    --network rabbitmq-perf-net \
    pivotalrabbitmq/go-stream-perf-test \
    --uris rabbitmq-stream://guest:guest@rabbitmq:5552/ \
    --publishers 1 \
    --consumers 0 \
    --streams measurement \
    --max-length-bytes=20GB \
    --variable-body 500 \
    --time 45
