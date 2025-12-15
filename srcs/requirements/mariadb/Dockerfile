# Use Alpine as base
FROM alpine:latest

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

COPY requirements/mariadb/conf/my.cnf /etc/my.cnf.d/mariadb.cnf

# Create MariaDB directories
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose default MariaDB port
EXPOSE 3306

# Start MariaDB
CMD ["mysqld", "--user=mysql", "--console"]
