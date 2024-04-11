# compare-rabbitmq-clients

This repository contains scripts to create a local test environment to measure differences in consumption performance between rabbitmq clients even with latencies (e.g., in a cloud environment).

To launch the tests:

```sh
make
```

This script will create 2 files (one for `golang` and one for `java`) that will compare the performance of the two clients while consuming the stream and with an indication of the test latency.
To change this latency check the [Makefile](./Makefile) and update the `--delay` argument (it is in `ms`).

As it is at the moment the delay is only client-side, but you can also add it server-side by adding `--label com.docker-tc.enabled=1 --label com.docker-tc.delay=5ms` in the creation of the rabbitmq container in [create-env.sh](./scripts/create-env.sh).

To clear the environment:

```sh
make clear
```
