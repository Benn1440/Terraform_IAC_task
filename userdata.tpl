#!/bin/bash
# Update the package index
sudo apt-get update -y
# Install PostgreSQL
sudo apt-get install postgresql postgresql-contrib -y
# Enable and start the PostgreSQL service
sudo systemctl enable postgresql
sudo systemctl start postgresql