#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <topic> <second>"
    exit 1
fi

TOPIC=$1
LAST_SECOND=$2

result=$(~/.scripts/check_connection.sh kafka)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

command="/usr/local/kafka/bin/kafka-console-consumer.sh \
        --bootstrap-server localhost:9092 \
        --topic $TOPIC \
        --timeout-ms $((LAST_SECOND * 1000)) \
        --max-messages 1"

result=$(~/.scripts/run_command.sh kafka "$command")

if echo "$result" | grep -q '{'; then
    echo "OK"
else
    echo "NO DATA"
fi

exit 0
