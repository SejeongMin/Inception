FROM debian:buster

# 인증서 발급
RUN apt-get update && \
	apt -y install lsb-release apt-transport-https ca-certificates wget && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# php8.1, wp-cli download
RUN apt-get update && apt-get install -y php8.1-fpm php8.1-mysqli mariadb-client curl redis-tools dumb-init && \
	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

EXPOSE 9000

COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/
COPY ./tools/wordpress_start.sh /tmp/

RUN chmod +x /tmp/wordpress_start.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "/tmp/wordpress_start.sh" ]

# php-fpm -F, --nodaemonize option: force to stay in foreground, ignore daemonize options from config file
CMD [ "php-fpm8.1", "-F" ]