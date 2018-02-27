#!/usr/bin/env bash
#set -e

echo "Change permissions on /var/run/docker.sock"
chown root:docker /var/run/docker.sock

echo "Change permissions on /apidocs"
chown root:jenkins /apidocs

echo "Allow jenkins writing to /apidocs"
chmod g+w /apidocs

# Add the permission group of docker.sock to Jenkins user.
# usermod -a -G $(stat -c "%G"  /var/run/docker.sock) jenkins
exec "$@"
