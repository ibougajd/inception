FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd

COPY tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 20 21 21100-21110

CMD ["/script.sh"]
