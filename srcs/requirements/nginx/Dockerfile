# Use the penultimate stable version of Debian 'Bullseye' as the base image
FROM debian:bullseye

# Update the package list and install Nginx
# -y answers yes to all prompts
RUN apt-get update && apt-get install -y nginx openssl

# Copy our custom Nginx configuration to the default site location
COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY tools/ssl.sh /bin/ssl.sh

RUN chmod +x /bin/ssl.sh && /bin/ssl.sh

# Expose port 80 to allow external access
EXPOSE 443

# Start Nginx in the foreground so the container doesn't stop
CMD ["nginx", "-g", "daemon off;"]
