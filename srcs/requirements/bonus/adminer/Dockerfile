FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    php7.4 \
    php7.4-mysql

COPY tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 8080

CMD ["/script.sh"]
