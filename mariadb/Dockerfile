FROM debian:bullseye

RUN apt update
RUN apt install -y mariadb-server mariadb-client
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 777 /var/lib/mysql

COPY mariadb.conf /etc/mysql/mariadb.conf
COPY init.sh /docker-entrypoint-initdb.d/init.sh

ENTRYPOINT [ "/docker-entrypoint-initdb.d/init.sh" ]