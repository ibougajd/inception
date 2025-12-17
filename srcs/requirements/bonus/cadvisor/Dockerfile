FROM debian:bullseye

RUN apt-get update && apt-get install -y wget

# Download cAdvisor binary
RUN wget https://github.com/google/cadvisor/releases/download/v0.37.5/cadvisor -O /usr/bin/cadvisor
RUN chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["/usr/bin/cadvisor", "-logtostderr", "--port=8080"]
