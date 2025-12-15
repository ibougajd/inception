FROM alpine:latest

COPY requirements/wordpress/aa.sh /usr/local/bin

RUN chmod +x /usr/local/bin/aa.sh

RUN apk add --no-cache \
    php83 php83-fpm php83-opcache php83-curl php83-mysqli \
    php83-json php83-xml php83-mbstring php83-gd php83-zip \
    php83-session curl tar

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www

RUN cd /var/www \
 && curl -O https://wordpress.org/latest.tar.gz \
 && tar -xzf latest.tar.gz \
 && rm latest.tar.gz \
 && chown -R nobody:nobody wordpress


EXPOSE 9000

CMD ["/bin/sh", "-c", "/usr/local/bin/aa.sh && /usr/sbin/php-fpm83 -F"]

