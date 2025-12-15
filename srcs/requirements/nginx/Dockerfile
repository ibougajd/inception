FROM alpine:latest

# 1. Install Nginx
RUN apk add --no-cache nginx

# remove wrong path
RUN rm -f /etc/nginx/http.d/default.conf

# copy to correct directory
COPY requirements/nginx/conf/nginx.conf /etc/nginx/http.d/default.conf

# install openssl and add script
COPY requirements/nginx/tools/generate_ssl_certificate.sh /usr/local/bin/generate_ssl_certificate.sh

RUN chmod +x /usr/local/bin/generate_ssl_certificate.sh && \
    apk add --no-cache openssl && \
    /usr/local/bin/generate_ssl_certificate.sh /etc/nginx/ssl

EXPOSE 443

# 5. Create directory for PID file (needed for Nginx on Alpine)
RUN mkdir -p /run/nginx

CMD ["nginx", "-g", "daemon off;"]
