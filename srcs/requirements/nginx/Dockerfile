FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY tools/ssl.sh /bin/ssl.sh

RUN chmod +x /bin/ssl.sh && /bin/ssl.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
