.PHONY: all

all: env fill-queue run-go run-java

env:
	docker compose up docker-tc rabbitmq -d

clear:
	docker compose down

fill-queue:
	docker compose up stream-producer

run-go:
	./scripts/run-consumer.sh --kind go --delay 5

run-java:
	./scripts/run-consumer.sh --kind java --delay 5
