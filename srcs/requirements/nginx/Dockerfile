FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx openssl dumb-init

EXPOSE 443

# COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./conf/default /tmp/default
# COPY ./conf/default /etc/nginx/sites-available/
COPY ./tools/nginx_start.sh /tmp/

RUN chmod +x /tmp/nginx_start.sh

ENTRYPOINT [ "/usr/bin/dumb-init", "/tmp/nginx_start.sh" ]

# daemon off: nginx 서버를 foreground에서 실행
# -g option: global
CMD ["nginx", "-g", "daemon off;"]