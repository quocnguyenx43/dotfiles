#!/bin/bash

result=$(~/.scripts/check_connection.sh nd-sensor)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

# Native systemd services
NATIVE_SERVICES=(
    "nd"
    "nd-api"
    "nd-zmq-broker"
    "nd-zmq-server"
)

# Docker containers
DOCKER_SERVICES=(
    "nd-backend_nd-ui_1"
    "nd-backend_nd-user_1"
    "spark-master"
    "spark-worker-01"
    "spark-worker-02"
    "kafka"
    "mongo-primary"
    "mongo-secondary-01"
    "mongo-secondary-02"
    "zookeeper"
    "vault"
    "syslog-ng"
)

# Array to collect DOWN services/containers
native_service_down_list=()
container_service_down_list=()

# Check native services
for service in "${NATIVE_SERVICES[@]}"; do
    command="systemctl is-active $service"
    result=$(~/.scripts/run_command.sh nd-sensor "$command" 2>/dev/null | tr -d '\r')
    clean_result=$(echo "$result" | grep -E 'active|inactive|failed|activating|deactivating' | head -n1)

    if [[ "$clean_result" != "active" ]]; then
        native_service_down_list+=("$service")
    fi
done

# Check docker containers
for container in "${DOCKER_SERVICES[@]}"; do
    command="docker inspect -f '{{.State.Running}}' $container 2>/dev/null"
    result=$(~/.scripts/run_command.sh nd-sensor "$command" 2>/dev/null | tr -d '\r\n' | xargs)
    clean_result_1=$(echo "$result" | sed 's/^\[sudo\] password for ubuntu: //')
    clean_result_2=$(echo "$result" | sed 's/\[sudo\].*$//g' | xargs)

    if [[ "$clean_result_1" != "true" && "$clean_result_2" != "true" ]]; then
        container_service_down_list+=("$container")
    fi
done

message=""
has_one="false"

# Output results for native services
if [ "${#native_service_down_list[@]}" -ge 1 ]; then
    temp="${native_service_down_list[*]}"
    message+="[Down list]: $temp"
    has_one="true"
fi

# Output results for docker services
if [ "${#container_service_down_list[@]}" -ge 1 ]; then
    if [[ "$has_one" == "true" ]]; then
        message+=" "
    else
        message+="[Down list]: "
    fi
    temp="${container_service_down_list[*]}"
    message+="$temp"
fi

echo $message

exit 0
