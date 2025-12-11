# Use a specific, stable version of Alpine
FROM alpine:3.18 

# 1. Install packages
#    - 'php83-fpm' is the process manager.
#    - 'php83-opcache' is highly recommended for production performance.
RUN apk add --no-cache php83 php83-fpm php83-opcache php83-curl php83-mysqli php83-json php83-xml php83-mbstring php83-gd php83-zip php83-session 

# 2. Expose the port PHP-FPM listens on (default is 9000)
EXPOSE 9000

# 3. CRITICAL FIX: Run PHP-FPM in the foreground (-F flag)
#    When running in a container, the main process (PID 1) must stay in the 
#    foreground. Otherwise, the container thinks the service has exited and stops.
CMD ["/usr/sbin/php-fpm83", "-F"] 

# Optional: Add a configuration file if needed
# COPY www.conf /etc/php83/php-fpm.d/www.conf