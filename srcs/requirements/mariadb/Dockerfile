FROM debian:bullseye

RUN apt update && apt install -y mariadb-server mariadb-client -y

COPY tools/init.sh /bin/init.sh
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

RUN chmod +x /bin/init.sh

EXPOSE 3306

CMD ["/bin/init.sh"]