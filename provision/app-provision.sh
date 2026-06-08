#!/bin/bash

set -e

echo "Updating packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing base packages..."
sudo apt install -y 
git 
curl 
wget 
vim 
openssh-server 
ca-certificates 
gnupg 
lsb-release

echo "Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo "Installing Docker..."
sudo apt install -y docker.io

echo "Installing Docker Compose..."
sudo apt install -y docker-compose-v2

echo "Starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Provisioning completed."
echo "Log out and log back in for docker group changes to take effect."

