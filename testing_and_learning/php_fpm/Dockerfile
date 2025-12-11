FROM alpine:latest

# 1. Install PHP and extensions
RUN apk add --no-cache php83 php83-fpm php83-opcache php83-curl php83-mysqli php83-json php83-xml php83-mbstring php83-gd php83-zip php83-session

# 2. Configure PHP-FPM to listen on port 9000 (network accessible)
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf



# 3. Create the document root directory
WORKDIR /var/www/html

# 4. Copy application source code into the container
COPY ./src /var/www/html

EXPOSE 9000
CMD ["/usr/sbin/php-fpm83", "-F"]
