#!/bin/bash

# --- Configs ---

yabai_config() {
    # Paddings
    yabai -m config top_padding 5
    yabai -m config bottom_padding 5
    yabai -m config left_padding 5
    yabai -m config right_padding 5
    yabai -m config window_gap 5

    # Open new window in focused display
    yabai -m config window_origin_display focused

    # Split the focused window into two
    yabai -m config window_insertion_point focused

    # New window spawns to right and bottom
    yabai -m config window_placement second_child

    # Don't hide MacOS menubar
    yabai -m config menubar_opacity 1.0

    # Mouse
    yabai -m config mouse_modifier alt
    yabai -m config mouse_follows_focus on
    yabai -m config focus_follows_mouse off
    yabai -m config mouse_action1 move      # move: hold alt + drag and drop left click
    yabai -m config mouse_action2 resize    # resize: hold alt + drag and drop right click
    yabai -m config mouse_drop_action swap

    # Windows
    yabai -m config window_shadow on
    yabai -m config window_opacity on
    yabai -m config active_window_opacity 1.0 # focused window
    yabai -m config normal_window_opacity 1.0 # unfocused window
    yabai -m config window_zoom_persist on

    # Animation
    yabai -m config window_animation_duration 0.2

    # Layouts
    yabai -m config split_type auto

    # Display arrangement order [A -> B]
    yabai -m config display_arrangement_order horizontal

    # Prevents space for custom status bar (SketchyBar, Übersicht, etc)
    yabai -m config external_bar all:32:0
}

# --- Signals ---

yabai_signal() {
    # yabai -m signal --add event=space_changed action="sketchybar --trigger space_change"
    # yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
    yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus SPACE_ID=\$YABAI_SPACE_ID"
}

# --- Displays ---

DISPLAY_MAIN=main
DISPLAY_SIDE=side

get_display_index() {
    local label="$1"
    # Returns the numeric index (e.g., 1) for the given label (e.g., "main")
    yabai -m query --displays | jq -r ".[] | select(.label == \"$label\") | .index"
}

setup_display() {
    DISPLAYS=$(yabai -m query --displays)
    COUNT=$(echo "$DISPLAYS" | jq length)

    # --- CASE 1: Single Display ---
    if [ "$COUNT" -eq 1 ]; then
        yabai -m display 1 --label "$DISPLAY_MAIN"

    # --- CASE 2: Dual Displays ---
    elif [ "$COUNT" -eq 2 ]; then
        # Logic: Built-in usually has smaller area than External
        BUILTIN_IDX=$(echo "$DISPLAYS" | jq -r 'min_by(.frame.w * .frame.h) | .index')
        EXTERNAL_IDX=$(echo "$DISPLAYS" | jq -r 'max_by(.frame.w * .frame.h) | .index')

        # Apply Labels
        yabai -m display "$EXTERNAL_IDX" --label "$DISPLAY_MAIN"
        yabai -m display "$BUILTIN_IDX" --label "$DISPLAY_SIDE"
    fi
}

# --- Spaces ---

setup_space() {
    local target_display_label="$1"
    local space_label="$2"
    local space_order="$3"
    local default_layout="$4"

    # Resolve Display Label to Index
    local display_idx
    display_idx=$(get_display_index "$target_display_label")
    
    if [[ -z "$display_idx" ]]; then
        display_idx=$(yabai -m query --displays | jq '.[0].index')
    fi

    # Check if space exists already
    # If yes, we don't need to create/recycle, just ensure it's on the right display
    if ! yabai -m query --spaces --space "$space_label" >/dev/null 2>&1; then
        # Space doesn't exist -> Find a blank one or Create
        local recycle_idx=""

        # Try local blank space first
        recycle_idx=$(yabai -m query --spaces --display "$display_idx" | \
                      jq -r ".[] | select(.label == \"\") | .index" | head -n 1)

        # Create new if no local blank found
        if [[ -z "$recycle_idx" ]]; then
            # Focus display only if not already focused to avoid error
            cur_display=$(yabai -m query --displays --display | jq '.index')
            if [[ "$cur_display" != "$display_idx" ]]; then
                yabai -m display --focus "$display_idx"
            fi
            yabai -m space --create
            recycle_idx=$(yabai -m query --spaces --display "$display_idx" | jq '.[-1].index')
        fi

        # Apply Label
        yabai -m space "$recycle_idx" --label "$space_label"
    fi

    # Ensure Space is on the Correct Display
    # (In case an existing space with this label was floating on the wrong monitor)
    local current_display
    current_display=$(yabai -m query --spaces --space "$space_label" | jq '.display')

    if [[ "$current_display" != "$display_idx" ]]; then
        yabai -m space "$space_label" --display "$display_idx"
    fi

    # Enforce Order
    # We calculate the Target Global Index:
    # (First Index of Target Display) + (Desired Order - 1)

    local first_index_of_display
    first_index_of_display=$(yabai -m query --spaces --display "$display_idx" | jq '.[0].index')

    local target_global_index=$((first_index_of_display + space_order - 1))
    local current_global_index
    current_global_index=$(yabai -m query --spaces --space "$space_label" | jq '.index')

    if [[ "$current_global_index" != "$target_global_index" ]]; then
        yabai -m space "$space_label" --move "$target_global_index"
    fi

    # Apply Layout
    yabai -m space "$space_label" --layout "$default_layout"
}

# setup_all_space() {
#     # Setup spaces on Main Display
#     setup_space "$DISPLAY_MAIN" "default-1"  1  "stack"
#     setup_space "$DISPLAY_MAIN" "any-1"      2  "float"
# 
#     # Setup spaces on Side Display
#     setup_space "$DISPLAY_SIDE" "default-2"  1  "stack"
#     setup_space "$DISPLAY_SIDE" "any-2"      2  "float"
#     setup_space "$DISPLAY_SIDE" "messages"   3  "bsp"
#     setup_space "$DISPLAY_SIDE" "notes"      4  "bsp"
# }

destroy_all_spaces() {
    yabai -m query --spaces | \
        jq -r 'reverse | .[].index' | \
        xargs -I {} yabai -m space {} --destroy 2>/dev/null
}

# --- Apps ---

# Unmanaged apps
UNMANAGED_APPS=(
    # MacOS
    "Finder"
    "Music"
    "Shortcuts"
    "System Settings"
    "Calculator"
    "QuickTime Player"
    "Photos"
    "Clock"
    "Find My"
    "Calendar"
    "Reminders"
    "Messages"
    "Weather"
    "Maps"
    "Contacts"
    "FaceTime"
    "Voice Memos"
    "News"
    "Podcasts"
    "Home"
    "TV"
    "Passwords"
    "Stocks"
    "Photo Booth"
    "Books"
    "QuickTime Player"

    # Other
    "Karabiner-Elements"
    "Karabiner-EventViewer"
    "KeePassXC"
)

# Default 1 apps
DEFAULT_1_APPS=(
    "Brave Browser"
    "Safari"
)

# Any 1 apps
ANY_1_APPS=(
    "Finder"
    "System Settings"
    "App Store"
    "Spotify"
    "OpenVPN Connect"
    "Uninstall OpenVPN Connect"
    "KeePassXC"
    "CopyQ"
)

# Note apps
NOTE_APPS=(
    "Sublime Text"
    "Notion"
    "Notes"
    "TextEdit"
)

# Message apps
MESSAGE_APPS=(
    "Zalo"
    "Telegram"
)

organize_windows() {
    # Cache current state (Performance: query once, not 50 times)
    local all_windows
    all_windows=$(yabai -m query --windows)

    local all_spaces
    all_spaces=$(yabai -m query --spaces)

    # Helper to process a list of apps
    move_apps() {
        local target_label="$1"
        local fallback_label="$2"
        shift 2
        local apps=("${@}") # Capture the rest of arguments as array

        # Determine valid destination
        local final_dest="$target_label"

        # Check if target space exists in the cached spaces list
        if ! echo "$all_spaces" | jq -e ".[] | select(.label == \"$target_label\")" > /dev/null; then
            final_dest="$fallback_label"
        fi

        # Iterate through apps in this group
        for app in "${apps[@]}"; do
            # Find window IDs for this app
            # usage: select(.app == "Brave Browser")
            local ids
            ids=$(echo "$all_windows" | jq -r ".[] | select(.app == \"$app\") | .id")

            # If IDs found, move them
            if [[ -n "$ids" ]]; then
                echo "$ids" | xargs -I {} yabai -m window {} --space "$final_dest"
                echo "Moved '$app' to $final_dest"
            fi
        done
    }

    # Execution Groups
    # Format: move_apps "TARGET_LABEL" "FALLBACK_LABEL" "${ARRAY[@]}"

    move_apps "default-1" "default-1" "${DEFAULT_1_APPS[@]}"
    move_apps "any-1"     "default-1" "${ANY_1_APPS[@]}"

    # Notes/Messages go to Side Display spaces ("notes", "messages")
    # If Side Display is unplugged, they fall back to "default-1" (Main)
    move_apps "notes"     "default-1" "${NOTE_APPS[@]}"
    move_apps "messages"  "default-1" "${MESSAGE_APPS[@]}"
}

setup() {
    # Setup displays (labels)
    setup_display

    # # Destroy all spaces first
    # destroy_all_spaces

    # Setup all spaces
    # setup_all_space

    # yabai config
    yabai_config

    # yabai signal
    yabai_signal

    for app in "${UNMANAGED_APPS[@]}"; do
        yabai -m rule --add app="^${app}$" manage=off
    done

    # organize_windows
}
