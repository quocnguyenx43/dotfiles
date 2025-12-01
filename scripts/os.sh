#!/usr/bin/env bash

# ----------------------------------------
# Resolve script directory
# ----------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_SCRIPTS="$SCRIPT_DIR/../scripts/os"

# sudo usermod -aG docker $USER
# newgrp docker

# if [[ "$OS" == "macos" ]]; then
#     echo "Configuring macOS..."
#     echo "OS Version: $OS_VERSION"
#     chmod +x ./os_settings/macos-settings.sh && ./os_settings/macos-settings.sh && wait
#     chmod +x ./os_settings/macos-tools.sh && ./os_settings/macos-tools.sh && wait
# elif [[ "$OS" == "ubuntu" ]]; then
#     echo "Configuring Ubuntu..."
#     echo "OS Version: $OS_VERSION"
#     echo "Configuring Ubuntu..."
#     chmod +x ./os_settings/ubuntu-settings.sh && sudo ./os_settings/ubuntu-settings.sh && wait
#     chmod +x ./os_settings/ubuntu-tools.sh && sudo ./os_settings/ubuntu-tools.sh && wait
#     chmod +x ./os_settings/ubuntu-monitor-selection.sh && ./os_settings/ubuntu-monitor-selection.sh && wait
#     chmod +x ./os_settings/ubuntu-monitor-setup.sh && ./os_settings/ubuntu-monitor-setup.sh && wait
# else
#     exit 1
# fi
