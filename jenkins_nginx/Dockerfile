FROM jwilder/nginx-proxy:alpine
MAINTAINER Thorsten Krug

RUN mkdir /etc/nginx/vhost.d
COPY ./conf/proxy_headers.conf /etc/nginx/vhost.d/default
