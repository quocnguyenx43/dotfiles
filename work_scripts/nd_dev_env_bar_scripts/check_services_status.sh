#!/bin/bash

result=$(~/.scripts/check_connection.sh be)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

# Native systemd services
NATIVE_SERVICES_BE=(
    "nd-api"
    "nd-zmq-broker"
    "nd-zmq-server"
)

# Docker containers in backend
DOCKER_SERVICES_BE=(
    "nd-users-srv-nd-ui-1"
    "nd-frontend-nd-ui-1"
)

# Docker containers in DB
DOCKER_SERVICES_DB=(
    "mongo-primary"
    "mongo-secondary-01"
    "mongo-secondary-02"
    "zookeeper"
    "vault"
    "syslog-ng"
    "kibana"
    "elasticsearch"
)

# Array to collect DOWN services/containers
native_service_down_list=()
container_service_down_list=()

# Check native services
for service in "${NATIVE_SERVICES_BE[@]}"; do
    command="systemctl is-active $service"
    result=$(~/.scripts/run_command.sh be "$command" 2>/dev/null | tr -d '\r')
    clean_result=$(echo "$result" | grep -E 'active|inactive|failed|activating|deactivating' | head -n1)

    if [[ "$clean_result" != "active" ]]; then
        native_service_down_list+=("$service")
    fi
done

# Check docker containers in BE
for container in "${DOCKER_SERVICES_BE[@]}"; do
    command="docker inspect -f '{{.State.Running}}' $container 2>/dev/null"
    result=$(~/.scripts/run_command.sh be "$command" 2>/dev/null | tr -d '\r\n' | xargs)
    clean_result_1=$(echo "$result" | sed 's/^\[sudo\] password for ubuntu: //')
    clean_result_2=$(echo "$result" | sed 's/\[sudo\].*$//g' | xargs)

    if [[ "$clean_result_1" != "true" && "$clean_result_2" != "true" ]]; then
        container_service_down_list+=("$container")
    fi
done

# Check docker containers in DB
for container in "${DOCKER_SERVICES_DB[@]}"; do
    command="docker inspect -f '{{.State.Running}}' $container 2>/dev/null"
    result=$(~/.scripts/run_command.sh db "$command" 2>/dev/null | tr -d '\r\n' | xargs)
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
