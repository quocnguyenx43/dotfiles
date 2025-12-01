#!/bin/bash

message=""

result1=$(~/.scripts/nd_dev_env_bar_scripts/check_services_status.sh)
result2=$(~/.scripts/nd_dev_env_bar_scripts/check_kafka_recent_data.sh nd-dpi 10)

# Initialize message with result1
message="$result1"

# Append result2 if not OK
if [[ "$result2" != "OK" ]]; then
    if [[ -n "$message" ]]; then
        message+=" | Kafka [nd-dpi]: $result2"
    else
        message="Kafka [nd-dpi]: $result2"
    fi
fi

# Output result or print "NOTHING"
if [[ -z "$message" ]]; then
    echo "None"
else
    echo "$message"
fi

exit 0
