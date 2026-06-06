#!/bin/bash

set -e

echo "Updating packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing base packages..."
sudo apt install -y 
curl 
wget 
vim 
unzip 
net-tools 
jq 
htop 
ca-certificates

echo "Installing OpenSSH..."
sudo apt install -y openssh-server

echo "Enabling SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo "Installing Docker..."
sudo apt install -y docker.io docker-compose-plugin

echo "Enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Provisioning completed."

