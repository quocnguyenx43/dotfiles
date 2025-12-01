#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set timezone to Asia/Ho_Chi_Minh
timedatectl set-timezone Asia/Ho_Chi_Minh

# # Configure power settings
# # Disable sleep when laptop lid is closed
# sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
# 
# # Set display settings
# # Set display resolution to 1920x1080
# xrandr --output $(xrandr | grep " connected" | cut -f1 -d " ") --mode 1920x1080
# 
# # Configure mouse settings
# # Set mouse speed/acceleration
# gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
# gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
# 
# # Configure touchpad settings
# gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
# gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
# 
# # Configure appearance
# # Set dark theme
# gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
# gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# 
# # Set desktop background to solid color
# gsettings set org.gnome.desktop.background picture-uri ''
# gsettings set org.gnome.desktop.background primary-color '#000000'
# 
# # Configure dock settings
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
# gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
# gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
# 
# # Configure window management
# gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
# gsettings set org.gnome.mutter center-new-windows true
# 
# # Configure privacy settings
# # Disable file history
# gsettings set org.gnome.desktop.privacy remember-recent-files false
# # Disable location services
# gsettings set org.gnome.system.location enabled false
# 
# # Configure power settings
# gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
# gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
# gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
# 
# # Set keyboard shortcuts
# # Screenshot shortcuts
# gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"
# 
# # Configure terminal settings
# # Set default terminal profile
# PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-color 'rgb(0,0,0)'
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ foreground-color 'rgb(255,255,255)'
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-transparent-background true
# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ background-transparency-percent 10
# 
# # Disable system sounds
# gsettings set org.gnome.desktop.sound event-sounds false

echo "Ubuntu configuration done"
