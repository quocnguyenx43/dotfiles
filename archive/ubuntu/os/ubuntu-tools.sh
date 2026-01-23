#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo`
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update the system
# # chmod +x ./apt/apt.sh && ./apt/apt.sh && wait
# echo "apt setup done"
# 
# # Enable UFW firewall
# ufw enable
# 
# # Add privileges to Docker
# usermod -aG docker "$USER"
# 
# # Change DNS to Google and Cloudflare (for faster): 8.8.8.8, 8.8.4.4
# # echo "nameserver 8.8.8.8" >> /etc/resolv.conf
# # echo "nameserver 1.1.1.1" >> /etc/resolv.conf
# 
# # Change owner of /opt/ to current user
# sudo chown -R "$USER:$USER" /opt
# 
# # Setup Kanata
# if ! getent group uinput > /dev/null; then
#     groupadd uinput
# fi
# 
# usermod -aG input $USER
# usermod -aG uinput $USER
# 
# echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' |\
#     tee /etc/udev/rules.d/99-input.rules > /dev/null
# 
# echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' |\
#     tee /etc/udev/rules.d/99-uinput.rules > /dev/null
# 
# udevadm control --reload-rules
# udevadm trigger
# 
# echo "User group result"
# ls -l /dev/uinput
# 
# sudo modprobe uinput
