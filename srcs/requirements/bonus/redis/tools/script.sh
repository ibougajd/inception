#!/bin/sh

# Configure redis to listen on all interfaces
sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /etc/redis/redis.conf
sed -i "s/# maxmemory <bytes>/maxmemory 256mb/g" /etc/redis/redis.conf
sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" /etc/redis/redis.conf

# Disable protected mode since we are in a container network
sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf

echo "Starting Redis..."
exec redis-server --protected-mode no
