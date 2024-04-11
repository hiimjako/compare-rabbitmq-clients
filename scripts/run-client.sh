#!/bin/bash 

# Set default value of delay flag to false
delay=false
kind=""

# Loop through command line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
        --debug) debug=true ;; # If --debug flag is provided, set debug to true
        --kind) kind="$2"; shift ;; # Set the kind variable
        *) echo "Unknown option: $1" ;;
    esac
    shift
done

if [ "$kind" != "go" ] && [ "$kind" != "java" ]; then
    echo "Error: Kind must be 'go' or 'java'"
    exit 1
fi

delay_options=""
file=$kind
if [ "$delay" = true ]; then
    file=$file-delay
    delay_options="--label com.docker-tc.enabled=1 --label com.docker-tc.delay=5ms"
fi
file=$file.log

if [ "$kind" = "java" ]; then
    docker run -it --rm \
        --network rabbitmq-perf-net \
        $delay_options \
        pivotalrabbitmq/stream-perf-test \
        --uris rabbitmq-stream://guest:guest@rabbitmq:5552 \
        -x=0 -y=1 -st=measurement -o=first -z=10 | tee $file
    exit
fi

if [ "$kind" = "go" ]; then
    docker run -it --rm \
        --network rabbitmq-perf-net \
        $delay_options \
        pivotalrabbitmq/go-stream-perf-test \
        --uris rabbitmq-stream://guest:guest@rabbitmq:5552/ \
        --publishers=0 --consumers=1 --streams=measurement --consumer-offset=first --max-length-bytes=20GB --time=10 | tee $file
    exit
fi
