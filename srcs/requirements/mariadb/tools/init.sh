#!/bin/bash

if [ -d "/var/lib/mysql/$DB_NAME" ]; then 
	echo "MariaDB already configured."
	exec mysqld_safe
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB data directory..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

mysqld_safe --skip-networking &
pid="$!"

echo "Configuring MariaDB for the first time..."

until mysqladmin ping >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 2
done

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

echo "MariaDB configuration complete."

mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown

wait "$pid"

exec mysqld_safe
