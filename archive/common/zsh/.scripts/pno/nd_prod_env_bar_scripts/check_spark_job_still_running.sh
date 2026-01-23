#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <job_name>"
    exit 1
fi

JOB=$1

result=$(~/.scripts/check_connection.sh nd-sensor)

if [[ "$result" != "OK" ]]; then
    echo "$result"
    exit 0
fi

command="docker exec spark-master ps aux | 
         grep '[o]rg.apache.spark.deploy.SparkSubmit' | 
         grep 'job-name $JOB'"

result=$(
    ~/.scripts/run_command.sh nd-sensor "$command" 2>/dev/null |
    sed 's/^\[sudo\] password for ubuntu: //' |
    xargs
)

if [[ -n "$result" ]]; then
    echo "OK"
else
    echo "NO JOB"
fi

exit 0
