#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <dir>"
    exit 1
fi

DIR=$1

result=$(~/.scripts/check_connection.sh nd-sensor)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

read -r -d '' command <<'EOF'
DIR="/home/ubuntu/nd-release-1.1/nd-docker-srv/syslog-ng/data/"
FILE=$(ls "/home/ubuntu/nd-release-1.1/nd-docker-srv/syslog-ng/data/" 2>/dev/null | head -n1)
FULL_PATH="/home/ubuntu/nd-release-1.1/nd-docker-srv/syslog-ng/data/$FILE"

if [[ ! -f "$FULL_PATH" ]]; then
    echo "Have no output file"
    exit 1
fi

SIZE_BEFORE=$(stat -c%s "$FULL_PATH")
sleep 5
SIZE_AFTER=$(stat -c%s "$FULL_PATH")

if [[ "$SIZE_AFTER" -gt "$SIZE_BEFORE" ]]; then
    echo "OK"
else
    echo "NOT UPDATED"
fi
EOF

result=$(
    ~/.scripts/run_command.sh nd-sensor "$command" 2>/dev/null |
    sed 's/^\[sudo\] password for ubuntu: //' |
    xargs
)

echo $result

exit 0
