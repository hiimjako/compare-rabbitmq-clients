.PHONY: all

all: env fill-queue run-go run-java clear

env:
	chmod +x ./scripts/create-env.sh && ./scripts/create-env.sh

clear:
	chmod +x ./scripts/clear-env.sh && ./scripts/clear-env.sh

fill-queue:
	chmod +x ./scripts/produce-messages.sh && ./scripts/produce-messages.sh

run-go:
	chmod +x ./scripts/run-client.sh && ./scripts/run-client.sh --kind go --delay 5

run-java:
	chmod +x ./scripts/run-consumer.sh && ./scripts/run-consumer.sh --kind java --delay 5
