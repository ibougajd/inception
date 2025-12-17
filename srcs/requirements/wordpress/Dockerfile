# Use Debian Bullseye as base
FROM debian:bullseye

# Update apt and install PHP-FPM and necessary extensions for WordPress
# wget and tar are for downloading WordPress
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-soap \
    php7.4-intl \
    php7.4-zip \
    wget \
    wget \
    tar \
    php7.4-redis

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM requires this directory to run
RUN mkdir -p /run/php

# Copy custom pool configuration to listen on port 9000
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy the startup script
COPY tools/start.sh /usr/local/bin/start.sh

# Make the startup script executable
RUN chmod +x /usr/local/bin/start.sh

# Expose port 9000 for Nginx to connect
EXPOSE 9000

WORKDIR /var/www/html

# Run the startup script
CMD ["/usr/local/bin/start.sh"]
