#!/bin/bash

echo "Installing Apache..."

sudo dnf install httpd -y

echo "Starting Apache..."

sudo systemctl enable httpd
sudo systemctl start httpd

echo "Deploying website..."

sudo cp ../src/index.html /var/www/html/index.html

echo "Deployment Complete!"

echo "Open:"
curl http://localhost
