#!/usr/bin/env bash
set -e
chown root:docker /var/run/docker.sock
chown root:jenkins /apidocs
chmod g+w /apidocs

# Add the permission group of docker.sock to Jenkins user.
# usermod -a -G $(stat -c "%G"  /var/run/docker.sock) jenkins
exec "$@"
