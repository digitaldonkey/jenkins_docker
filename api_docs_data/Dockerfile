# Needs to match the linux version used in jenkins-master
FROM debian:stretch
MAINTAINER Thorsten Krug

# user 1000 must match the user id for the jenkins user in jenkins-master
RUN useradd -d "/nonexistent" -u 1000 -m -s /usr/sbin/nologin jenkins

RUN mkdir -p /apidocs
RUN chown -R jenkins:jenkins /apidocs
RUN chmod 777 /apidocs

VOLUME ["/apidocs"]

USER jenkins


