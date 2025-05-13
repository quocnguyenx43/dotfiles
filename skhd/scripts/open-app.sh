#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <App Name>"
    exit 1
fi

osascript ~/.osascripts/open-app.applescript "$1"