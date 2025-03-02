FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

COPY ./tools/init.sh /etc/nginx/init.sh

ENTRYPOINT ["/etc/nginx/init.sh"]