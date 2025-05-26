#!/bin/bash

# Step 1: Define remote host and service
REMOTE_HOST="user@remote-host"
SERVICE_NAME="nd.service"

# Step 2: Check SSH connection & permission to run command
ssh -o BatchMode=yes -o ConnectTimeout=5 "$REMOTE_HOST" "true" 2>/dev/null
if [[ $? -ne 0 ]]; then
    # If unable to connect or authorize, exit silently
    exit 1
fi

# Step 3: Check the service status
STATUS=$(ssh "$REMOTE_HOST" "systemctl is-active $SERVICE_NAME" 2>/dev/null)

# Step 4: Output result
if [[ "$STATUS" == "active" ]]; then
    echo "✅ Service '$SERVICE_NAME' is running on $REMOTE_HOST"
else
    echo "❌ Service '$SERVICE_NAME' is NOT running on $REMOTE_HOST (status: $STATUS)"
fi