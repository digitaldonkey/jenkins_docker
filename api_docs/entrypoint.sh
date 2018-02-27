#!/usr/bin/env bash
set -e

echo "REPLACE <API_HOST> in /etc/nginx/conf.d/default.conf"
/bin/sed -i "s/<API_HOST>/${API_HOST}/" /etc/nginx/conf.d/default.conf

echo "REPLACE <API_PORT> in /etc/nginx/conf.d/default.conf"
/bin/sed -i "s/<API_PORT>/${API_PORT}/" /etc/nginx/conf.d/default.conf

echo "Start nginx"
/usr/sbin/nginx -g "daemon off;"

exec "$@"
