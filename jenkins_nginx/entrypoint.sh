#!/usr/bin/env bash
set -e

echo "REPLACE <JENKINS_HOST> in /etc/nginx/vhost.d/default.conf"
/bin/sed -i "s/<JENKINS_HOST>/${JENKINS_HOST}/" /etc/nginx/conf.d/default.conf

echo "REPLACE <JENKINS_PORT> in /etc/nginx/vhost.d/default.conf"
/bin/sed -i "s/<JENKINS_PORT>/${JENKINS_PORT}/" /etc/nginx/conf.d/default.conf

echo "Start nginx"
/usr/sbin/nginx -g "daemon off;"

exec "$@"
