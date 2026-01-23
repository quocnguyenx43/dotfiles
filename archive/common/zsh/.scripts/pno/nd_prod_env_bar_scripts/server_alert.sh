#!/bin/bash

message=""

result1=$(~/.scripts/nd_prod_env_bar_scripts/check_services_status.sh)
result2=$(~/.scripts/nd_prod_env_bar_scripts/check_syslog-ng_recent_data.sh /home/ubuntu/nd-release-1.1/docker/syslog-ng/data/)
result3=$(~/.scripts/nd_prod_env_bar_scripts/check_kafka_docker_recent_data.sh nd-dpi 10)
result4=$(~/.scripts/nd_prod_env_bar_scripts/check_spark_job_still_running.sh streaming)

# Initialize message with result1
message="$result1"

# Append result2 if not OK
if [[ "$result2" != "OK" ]]; then
    if [[ -n "$message" ]]; then
        message+=" | syslog-ng [~/nd-release-1.1/.../data/]: $result2"
    else
        message="syslog-ng [~/nd-release-1.1/.../data/]: $result2"
    fi
fi

# Append result3 if not OK
if [[ "$result3" != "OK" ]]; then
    if [[ -n "$message" ]]; then
        message+=" | Kafka [nd-dpi]: $result3"
    else
        message="Kafka [nd-dpi]: $result3"
    fi
fi

# Append result4 if not OK
if [[ "$result4" != "OK" ]]; then
    if [[ -n "$message" ]]; then
        message+=" | Spark [streaming]: $result4"
    else
        message="Spark [streaming]: $result4"
    fi
fi

# Output result or print "NOTHING"
if [[ -z "$message" ]]; then
    echo "None"
else
    echo "$message"
fi

exit 0
