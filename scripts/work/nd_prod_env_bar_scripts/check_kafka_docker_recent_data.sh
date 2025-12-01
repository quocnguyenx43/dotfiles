#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <topic> <second>"
    exit 1
fi

TOPIC=$1
LAST_SECOND=$2

result=$(~/.scripts/check_connection.sh nd-sensor)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

command="docker exec kafka kafka-console-consumer \
        --bootstrap-server localhost:9092 \
        --topic $TOPIC \
        --timeout-ms $((LAST_SECOND * 1000)) \
        --max-messages 1"

result=$(~/.scripts/run_command.sh nd-sensor "$command")

if echo "$result" | grep -q '{'; then
    echo "OK"
else
    echo "NO DATA"
fi

exit 0
