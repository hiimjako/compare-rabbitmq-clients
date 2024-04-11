.PHONY: all

all: env fill-queue run-go run-java

env:
	./scripts/create-env.sh

clear:
	./scripts/clear-env.sh

fill-queue:
	./scripts/produce-messages.sh

run-go:
	./scripts/run-consumer.sh --kind go --delay 5

run-java:
	./scripts/run-consumer.sh --kind java --delay 5
