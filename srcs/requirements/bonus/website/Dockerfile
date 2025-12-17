FROM debian:bullseye

RUN apt-get update && apt-get install -y nodejs npm

COPY tools/script.sh /
RUN chmod +x /script.sh

COPY conf/index.html /var/www/html/index.html
COPY conf/style.css /var/www/html/style.css

EXPOSE 1337

CMD ["/script.sh"]
