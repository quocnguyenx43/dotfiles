#!/usr/bin/env bash

MIN_WIDTH=80
CURRENT_WIDTH=$(tmux display -p '#{client_width}')

# If the terminal width is less than 80 columns, skip output
if [ "$CURRENT_WIDTH" -lt "$MIN_WIDTH" ]; then
  echo ""
  exit 0
fi

LATEST_FILE=$(ls -1t ~/Documents/git/scratch/todo_[0-9][0-9][0-1][0-9][0-3][0-9].md 2>/dev/null | head -n 1)

# If no TODO file is found, exit early
if [ -z "$LATEST_FILE" ]; then
  echo "📂 No todo file found."
  exit 0
fi

tasks=()
# Extract tasks from the most recent file
while IFS= read -r line; do
  tasks+=("$line")
done < <(awk '/^- \[ \] / {sub(/^- \[ \] /, ""); print}' "$LATEST_FILE")

# If no tasks are left, print "All done!" message
if [ "${#tasks[@]}" -eq 0 ]; then
  echo "🎧 All done!"
else
  task="${tasks[RANDOM % ${#tasks[@]}]}"
  # Remove checkbox prefix and print the task
  echo "⏰ $task" | sed 's/^- \[ \] //'
fi
