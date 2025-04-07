# Change DNS to Google (for faster): 8.8.8.8, 8.8.4.4
sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Enable firewall
sudo ufw enable

# Docker
sudo usermod -a -G docker $USER

sudo chown -R $USER:$USER /opt
