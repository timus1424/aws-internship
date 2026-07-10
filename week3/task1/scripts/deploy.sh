#!/bin/bash

echo "Updating system..."
sudo dnf update -y

echo "Installing Apache..."
sudo dnf install httpd -y

echo "Enabling Apache..."
sudo systemctl enable httpd

echo "Starting Apache..."
sudo systemctl start httpd

echo "Checking Apache status..."
sudo systemctl status httpd --no-pager

echo "Deployment complete."
