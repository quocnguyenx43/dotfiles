#!/usr/bin/env bash

# ----------------------------------------
# Resolve script directory
# ----------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$SCRIPT_DIR/../apps"

echo "Running cleaning script..."

# Clean apps
if [[ -d "$APP_DIR" ]]; then
    find "$APP_DIR" -mindepth 1 -maxdepth 1 ! -name 'Makefile' ! -name '.stowrc' -exec rm -rf {} +
fi
