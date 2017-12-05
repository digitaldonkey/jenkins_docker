#!/usr/bin/env bash


# USER root
# COPY ./entrypoint.sh /usr/local/sbin/
# ENTRYPOINT ["entrypoint.sh"]


set -e
usermod -a -G $(stat -c "%G"  /var/run/docker.sock) jenkins
su jenkins
exec "$@"
