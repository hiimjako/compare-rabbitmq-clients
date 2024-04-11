#!/bin/bash 

# Set default value of delay flag to false
delay=0
kind=""

# Loop through command line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
        --delay) delay=$2 ; shift ;; 
        --kind) kind="$2"; shift ;; 
        *) echo "Unknown option: $1" ;;
    esac
    shift
done

if [ "$kind" != "go" ] && [ "$kind" != "java" ]; then
    echo "Error: Kind must be 'go' or 'java'"
    exit 1
fi

delay_options=""
file="$(pwd)/$kind"
if [ "$delay" > 0 ]; then
    file=$file-delay
    delay_options="--label com.docker-tc.enabled=1 --label com.docker-tc.delay=${delay}ms"
fi
file=$file.log

if [ "$kind" = "java" ]; then
    docker run -it --rm \
        --network rabbitmq-perf-net \
        $delay_options \
        pivotalrabbitmq/stream-perf-test \
        --uris rabbitmq-stream://guest:guest@rabbitmq:5552 \
        -x=0 -y=1 -st=measurement -o=first -z=10 | tee "$file"
    exit
fi

if [ "$kind" = "go" ]; then
    docker run -it --rm \
        --network rabbitmq-perf-net \
        $delay_options \
        pivotalrabbitmq/go-stream-perf-test \
        --uris rabbitmq-stream://guest:guest@rabbitmq:5552/ \
        --publishers=0 --consumers=1 --streams=measurement --consumer-offset=first --max-length-bytes=20GB --time=10 | tee "$file"
    exit
fi
