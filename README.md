# compare-rabbitmq-clients

This repository contains scripts to create a local test environment to measure differences in consumption performance between rabbitmq clients even with latencies (e.g., in a cloud environment).

To launch the tests:

```sh
make
```

This script will create 2 files (one for `golang` and one for `java`) that will compare the performance of the two clients while consuming the stream and with an indication of the test latency.
To change this latency check the [Makefile](./Makefile) and update the `--delay` argument (it is in `ms`).

As it is at the moment the delay is only client-side, but you can also add it server-side by adding `--label com.docker-tc.enabled=1 --label com.docker-tc.delay=5ms` in the creation of the rabbitmq container in [docker-compose](./docker-compose.yml).

To clear the environment:

```sh
make clear
```

## Benchmark

In the [benchmark](./benchmark/) directory, you'll find the results from my local machine. It appears that:

- Without any delay, the Java client is 4x faster in a local environment.
- With a 5ms delay, it seems the Java client is around 20x faster.
- With a 10ms delay, it seems the Java client is around 22x faster.

It appears that there are differences in how the client handles connections or things like that.
Also, in the java client it seems that the reduction in performance is about linear with respect to the increase in latency (as we should expect, I guess), while in the go client it seems much steeper.
