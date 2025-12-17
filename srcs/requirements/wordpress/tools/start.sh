#!/bin/bash

# Check if wp-config.php exists
if [ -f ./wp-config.php ]
then
	echo "wordpress already installed"
else

	# Download WordPress
	wp core download --allow-root

	# Create wp-config.php
	wp config create \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASSWORD \
		--dbhost=$DB_HOST \
		--allow-root

	# Configure Redis
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root
	
	# Install Redis Object Cache Plugin
	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root

	# Install WordPress
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$TITLE \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--allow-root

	# Create a second user
	wp user create \
		$USER1_USER \
		$USER1_EMAIL \
		--role=author \
		--user_pass=$USER1_PASS \
		--allow-root
fi

# Start PHP-FPM in foreground
exec php-fpm7.4 -F
