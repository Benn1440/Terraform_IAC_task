#!/bin/bash
# Update the package repository
sudo yum update -y
# Install Nginx
sudo amazon-linux-extras install nginx1 -y
# Start Nginx service
sudo systemctl start nginx
# Enable Nginx to start on boot
sudo systemctl enable nginx