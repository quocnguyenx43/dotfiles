#!/bin/bash

direction="$1"
if [[ "$direction" != "left" && "$direction" != "right" ]]; then
    echo "Usage: $0 left|right"
    exit 1
fi

# JSON layout of i3
tree_json=$(i3-msg -t get_tree)

# Focused window ID
focused_id=$(jq '.. | select(.focused? == true) | .id' <<< "$tree_json")

# echo "Focused window ID: $focused_id"

if [[ -z "$focused_id" ]]; then
    echo "Focused window not found"
    exit 1
fi

# Parent json
parent=$(jq --argjson id "$focused_id" '.. | select(.nodes? and (.nodes[] | select(.id == $id)))' <<< "$tree_json")

# echo "Focused Parent ID: $parent"

if [[ -z "$parent" ]]; then
    echo "Parent container not found"
    exit 1
fi

# echo "$parent" > parent.json

# Siblings
parent_nodes=$(jq '.nodes' <<< "$parent")
in_left=1
printed=0

echo "$parent_nodes" | jq -c '.[]' | while read -r node; do
    node_id=$(jq -r '.id' <<< "$node")
    node_name=$(jq -r '.window_properties.class // "N/A"' <<< "$node")
    node_title=$(jq -r '.window_properties.title // "N/A"' <<< "$node")

    if [[ "$node_id" == "$focused_id" ]]; then
        in_left=0
        continue
    fi

    case "$node_name" in
        "Code" | "code")
            dir=$(echo "$node_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            # node_name="Code ($dir)"
            node_name="Code"
            ;;
        "Nautilus" | "org.gnome.Nautilus")
            # node_name="Nautilus ($node_title)"
            node_name="Nautilus"
            ;;
        "Thunar" | "thunar")
            dir=$(echo "$node_title" | awk -F ' - ' '{print $(NF-1)}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            # node_name="Thunar ($dir)"
            node_name="Thunar"
            ;;
        "Dolphin" | "dolphin")
            dir=$(echo "$node_title" | sed -E 's/ — Dolphin$//')
            # node_name="Dolphin ($dir)"
            node_name="Dolphin"
            ;;
        "firefox" | "Firefox" | "firefox_firefox")
            node_name="Firefox"
            ;;
    esac

    if [[ "$direction" == "left" && $in_left -eq 1 ]]; then
        [[ $printed -eq 1 ]] && echo -n " | "
        echo -n $node_name
        printed=1
    elif [[ "$direction" == "right" && $in_left -eq 0 ]]; then
        [[ $printed -eq 1 ]] && echo -n " | "
        echo -n $node_name
        printed=1
    fi
done
