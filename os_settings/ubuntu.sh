#!/bin/bash

# Enable firewall
sudo ufw enable

# Docker
sudo usermod -a -G docker $USER

# Change DNS to Google and Cloudflare (for faster): 8.8.8.8, 8.8.4.4
# sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
# sudo echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Setup tips
# - Change DNS to Google for faster internet (script)
# - Enable firewall - ufw (script)
# - Config docker user (scrip)
# - Change owner /opt/ to $USER