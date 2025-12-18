FROM debian:bullseye

RUN apt-get update && apt-get install -y nodejs npm && npm install -g http-server

COPY tools/script.sh /
RUN chmod +x /script.sh

COPY public/ /var/www/html/

EXPOSE 1337

CMD ["/script.sh"]
