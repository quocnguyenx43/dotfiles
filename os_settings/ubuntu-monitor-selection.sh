#!/bin/bash

echo
PC_PRIMARY_MONITOR="$HOME/.zsh_primary_monitor"
PC_SECONDARY_MONITOR="$HOME/.zsh_secondary_monitor"
PC_PRIMARY_ON_RIGHT="$HOME/.zsh_primary_monitor_on_right"
ZPROFILE="$HOME/.zprofile"

# Check if monitor config files exist already
if [[ -f "$PC_PRIMARY_MONITOR" && -f "$PC_SECONDARY_MONITOR" && -f "$PC_PRIMARY_ON_RIGHT" ]]; then
    echo "Monitor configuration already exists."
    echo "Primary monitor      : $(<"$PC_PRIMARY_MONITOR")"
    echo "Secondary monitor    : $(<"$PC_SECONDARY_MONITOR")"
    echo "Primary on right side: $(<"$PC_PRIMARY_ON_RIGHT")"
    echo
else
    # Get connected monitors
    monitors=($(xrandr --query | grep " connected" | cut -d' ' -f1))

    if [[ ${#monitors[@]} -eq 0 ]]; then
        echo "No connected monitors detected."
        exit 1
    fi

    echo "Connected monitors:"
    for i in "${!monitors[@]}"; do
        echo "$((i+1))) ${monitors[$i]}"
    done

    if [[ ${#monitors[@]} -eq 1 ]]; then
        PRIMARY_MONITOR="${monitors[0]}"
        echo "$PRIMARY_MONITOR" > "$PC_PRIMARY_MONITOR"
        echo "" > "$PC_SECONDARY_MONITOR"
        echo "0" > "$PC_PRIMARY_ON_RIGHT"
        echo "Only one monitor detected. Primary monitor set to: $PRIMARY_MONITOR"
        echo
    else
        # Prompt for primary monitor choice
        while true; do
            read -rp "Choose the PRIMARY monitor (1-${#monitors[@]}): " primary_choice
            if [[ "$primary_choice" =~ ^[1-9][0-9]*$ ]] && (( primary_choice >= 1 && primary_choice <= ${#monitors[@]} )); then
                PRIMARY_MONITOR="${monitors[$((primary_choice-1))]}"
                break
            else
                echo "Invalid choice, please try again."
            fi
        done

        # Prompt for secondary monitor choice
        while true; do
            read -rp "Choose the SECONDARY monitor (1-${#monitors[@]}), different from primary: " secondary_choice
            if [[ "$secondary_choice" =~ ^[1-9][0-9]*$ ]] && (( secondary_choice >= 1 && secondary_choice <= ${#monitors[@]} )); then
                SECONDARY_MONITOR="${monitors[$((secondary_choice-1))]}"
                if [[ "$SECONDARY_MONITOR" != "$PRIMARY_MONITOR" ]]; then
                    break
                else
                    echo "Secondary monitor cannot be the same as primary. Try again."
                fi
            else
                echo "Invalid choice, please try again."
            fi
        done

        # Prompt if primary monitor is on the right
        while true; do
            read -rp "Is the PRIMARY monitor on the RIGHT side? (y/n): " yn
            case $yn in
                [Yy]* ) PRIMARY_ON_RIGHT=1; break;;
                [Nn]* ) PRIMARY_ON_RIGHT=0; break;;
                * ) echo "Please answer y or n.";;
            esac
        done

        # Save monitor info to files
        echo "$PRIMARY_MONITOR" > "$PC_PRIMARY_MONITOR"
        echo "$SECONDARY_MONITOR" > "$PC_SECONDARY_MONITOR"
        echo "$PRIMARY_ON_RIGHT" > "$PC_PRIMARY_ON_RIGHT"

        echo "Primary monitor saved as: $PRIMARY_MONITOR"
        echo "Secondary monitor saved as: $SECONDARY_MONITOR"
        echo "Is primary monitor on the right? : $PRIMARY_ON_RIGHT"
        echo
    fi
fi

# Function to add or update export lines in ~/.zprofile
add_or_update_export() {
    local varname=$1
    local filepath=$2
    local export_line="export $varname=\"\$(cat $filepath)\""

    # If the line exists, replace it; if not, append it
    if grep -q "^export $varname=" "$ZPROFILE" 2>/dev/null; then
        # Replace existing line
        sed -i.bak "s|^export $varname=.*|$export_line|" "$ZPROFILE"
    else
        # Append line
        echo "$export_line" >> "$ZPROFILE"
    fi
}

echo "Updating $ZPROFILE with monitor exports..."

add_or_update_export PRIMARY_MONITOR "$PC_PRIMARY_MONITOR"
add_or_update_export SECONDARY_MONITOR "$PC_SECONDARY_MONITOR"
add_or_update_export PRIMARY_MONITOR_ON_RIGHT "$PC_PRIMARY_ON_RIGHT"

echo "Done. Please reload your shell or run 'source ~/.zprofile' to apply changes."
