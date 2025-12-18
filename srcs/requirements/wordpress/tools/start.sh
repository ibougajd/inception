#!/bin/bash

if [ -f ./wp-config.php ]
then
	echo "wordpress already installed"
else

	wp core download --allow-root

	while ! mysqladmin ping -h"$DB_HOST" --silent; do
		sleep 1
	done

	wp config create \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASSWORD \
		--dbhost=$DB_HOST \
		--allow-root


	wp core install \
		--url=$DOMAIN_NAME \
		--title=$TITLE \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--allow-root

	wp user create \
		$USER1_USER \
		$USER1_EMAIL \
		--role=author \
		--user_pass=$USER1_PASS \
		--allow-root
fi

	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp redis enable --allow-root

exec php-fpm7.4 -F
