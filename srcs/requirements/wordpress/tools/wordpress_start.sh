# #!/bin/bash

# 	# sed -i "s/listen = \/run\/php\/php8.1-fpm.sock/listen = 9000/" "/etc/php/8.1/fpm/pool.d/www.conf";
# sed -e
	
# 	# mkdir -p /run/php/;
# 	# touch /run/php/php8.1-fpm.pid;

# if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
# 	echo "Wordpress: setting up..."

# 	cp /tmp/wp-config.php /var/www/html/wordpress/wp-config.php

# 	# wait for MariaDB
# 	sleep 5;

# 	# mkdir -p /var/www/wordpress

# 	# cd /var/www/wordpress;

# 	wp config create --dbname=wordpress --dbuser=semin --dbpass=1234 --dbhost=mariadb --allow-root;

# 	# mv /var/www/wp-config.php /var/www/wordpress/
# 	echo "Wordpress: creating users..."
# 	wp core install --allow-root --url=semin.42.fr --title="wordpress" --admin_user=semin --admin_password=1234 --admin_email=semin@42.fr --skip-email
# 	wp user create --allow-root wpuser wpuser@42.fr --user_pass=1234 --role=author --allow-root

# 	# nginx 서버에서 운용 가능
# 	# chown -R www-data:www-data /var/www/*;
# 	chown -R www-data:www-data /var/www/html/wordpress
# 	# chown -R 755 /var/www/*;

# 	echo "Wordpress: set up!"
# fi

# service php8.1-fpm start
# service php8.1-fpm stop

# echo "Starting Wordpress Container..."

# exec "$@"

#!/bin/bash
set -e

cd /var/www/html/wordpress

if [ ! -f /var/www/html/wordpress/index.php ]; then
	wp core download --allow-root
fi

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp config create --dbname=wordpress --dbuser=semin --dbpass=1234 --dbhost=mariadb --allow-root

	wp core install --url=semin.42.fr --title="semin inception" --admin_user=semin --admin_password=1234 --admin_email=semin@student.42seoul.kr --skip-email --allow-root
	wp user create wpuser wpuser@student.42seoul.kr --user_pass=1234 --role=author --allow-root

	chown -R www-data:www-data /var/www/html/wordpress
fi

service php8.1-fpm start
service php8.1-fpm stop

echo "Starting Wordpress Container..."

exec "$@"