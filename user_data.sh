#!/bin/bash
# Update and install Apache
sudo yum update -y
sudo yum install -y httpd

# Start Apache and enable it on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a simple index.html page
echo "<h1>Welcome to My Web Server - $(hostname)</h1>" | sudo tee /var/www/html/index.html

# Adjust permissions
sudo chmod 755 /var/www/html/index.html
