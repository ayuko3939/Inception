FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init.sh /docker-entrypoint-initdb.d/init.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/init.sh"]