#!/bin/bash

# Install http-server globally
npm install -g http-server

# Serve the directory
echo "Starting Static Website..."
exec http-server /var/www/html -p 1337
