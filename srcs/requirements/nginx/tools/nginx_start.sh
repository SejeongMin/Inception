#!/bin/bash

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Nginx: setting up ssl ...";

    # self-signed ssl certification
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout $CERTS_KEY -out $CERTS_ -subj "/C=KR/ST=Seoul/L=Seoul/O=wordpress/CN=$DOMAIN_NAME";
    echo "Nginx: ssl is set up!";
    # cp /tmp/default /etc/nginx/conf.d/default.conf

    # wait for wordpress
    sleep 5;
fi

echo "Starting Nginx..."

# dockerfile CMD 인수 실행 보장
exec "$@"