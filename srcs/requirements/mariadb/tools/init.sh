#!/bin/bash

# Start MariaDB in the background safely
mysqld_safe --skip-networking &
pid="$!"

# Wait for MariaDB to be ready
until mysqladmin ping >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 2
done

# Run the initialization commands
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown the temporary MariaDB instance
mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown

# Wait for the background process to exit
wait "$pid"

# Start MariaDB normally in the foreground
exec mysqld_safe
