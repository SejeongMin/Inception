#!/bin/bash
set -e

cd /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/index.php ]; then
	wp core download --allow-root
fi

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_ADMIN_LOGIN} --dbpass=${WP_ADMIN_PASSWORD} --dbhost=mariadb --allow-root

	wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
	wp user create ${WP_USER_LOGIN} ${WP_USER_PASSWORD} --user_pass=1234 --role=author --allow-root

	# nginx 서버에서 운용 가능
	chown -R www-data:www-data /var/www/html/wordpress
fi

service php8.1-fpm start
service php8.1-fpm stop

echo "Starting Wordpress Container..."

exec "$@"