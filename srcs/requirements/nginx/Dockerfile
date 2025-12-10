FROM nginx:alpine

# remove default server and copy our server block
RUN rm -f /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY tools/index.html /usr/share/nginx/html/


# install openssl and add script
COPY tools/generate_ssl_certificate.sh /usr/local/bin/generate_ssl_certificate.sh
RUN chmod +x /usr/local/bin/generate_ssl_certificate.sh && \
    apk add --no-cache openssl && \
    /usr/local/bin/generate_ssl_certificate.sh /etc/nginx/ssl

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
