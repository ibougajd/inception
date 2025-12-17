#!/bin/bash

# Download Adminer
mkdir -p /var/www/html
wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php

# Start PHP built-in server
echo "Starting Adminer..."
# Bind to 0.0.0.0:8080
exec php -S 0.0.0.0:8080 -t /var/www/html
