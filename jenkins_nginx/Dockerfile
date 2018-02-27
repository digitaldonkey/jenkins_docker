FROM jwilder/nginx-proxy:alpine
MAINTAINER Thorsten Krug

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/vhost.d
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

COPY ./entrypoint.sh /usr/local/sbin/
ENTRYPOINT ["entrypoint.sh"]
