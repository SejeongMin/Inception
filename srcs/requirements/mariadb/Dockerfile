FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server dumb-init

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/initial_db.sql /var/www/

RUN service mysql start && mysql < /var/www/initial_db.sql && rm -f /var/www/initial_db.sql;
# sh 따로 빼기

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["mysqld"]