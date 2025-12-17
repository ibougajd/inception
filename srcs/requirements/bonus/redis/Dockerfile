FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server php-redis

COPY tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 6379

CMD ["/script.sh"]
