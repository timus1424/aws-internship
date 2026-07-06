#!/bin/bash

# Update package repository
sudo dnf update -y

# Install Apache Web Server
sudo dnf install httpd -y

# Start Apache
sudo systemctl start httpd

# Enable Apache on boot
sudo systemctl enable httpd

# Create sample webpage
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Timus AWS Internship</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:100px;">
    <h1>🚀 My First AWS EC2 Website</h1>
    <h2>Cloud Computing / AWS Internship</h2>
    <p>Successfully deployed on Amazon EC2 using Apache Web Server.</p>
    <hr>
    <p>Created by <strong>Timus</strong></p>
</body>
</html>
EOF

echo "Web server installation completed."y
