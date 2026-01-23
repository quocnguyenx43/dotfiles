#!/bin/bash

direction="$1"
layout=$(yabai -m query --spaces --space | jq -r .type)

if [[ "$layout" == "stack" ]]; then
    if [[ "$direction" == "west" ]]; then
        yabai -m window --focus "stack.prev"
    elif [[ "$direction" == "east" ]]; then
        yabai -m window --focus "stack.next"
    fi
else
    yabai -m window --focus "$direction"
fi
