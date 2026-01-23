#!/bin/bash

direction="$1"
current_id=$(yabai -m query --windows --window | jq '.id')
layout=$(yabai -m query --spaces --space | jq -r .type)

if [[ "$layout" == "stack" ]]; then
    if [[ "$direction" == "west" ]]; then
        yabai -m window --swap "stack.prev" && yabai -m window --focus "$current_id"
    elif [[ "$direction" == "east" ]]; then
        yabai -m window --swap "stack.next" && yabai -m window --focus "$current_id"
    fi
else
    yabai -m window --swap "$direction" && yabai -m window --focus "$current_id"
fi
