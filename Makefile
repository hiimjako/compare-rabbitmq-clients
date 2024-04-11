env:
	chmod +x ./scripts/create-env.sh && ./scripts/create-env.sh

clear:
	chmod +x ./scripts/clear-env.sh && ./scripts/clear-env.sh

fill-queue:
	chmod +x ./scripts/produce-messages.sh && ./scripts/produce-messages.sh

run:
	chmod +x ./scripts/run-client.sh && ./scripts/run-client.sh