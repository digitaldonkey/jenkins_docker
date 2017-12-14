FROM jenkins/jenkins:lts
MAINTAINER Thorsten Krug

USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R  jenkins:jenkins /var/log/jenkins
RUN chown -R  jenkins:jenkins /var/cache/jenkins

# Install Docker client
# 999 should be the gid on /var/run/docker.sock
RUN groupadd docker --gid 999
RUN usermod -a -G docker jenkins

# Install docker binaries
RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz | tar xvz -C /tmp && mv /tmp/docker/docker* /usr/bin

# Install doxygen
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    doxygen graphviz \
 && rm -rf /var/lib/apt/lists/*

# Install Jenkins
USER jenkins
ENV JAVA_OPTS="-Xmx4096m"

# Install plugins; the plugins.txt file can be exported from Jenkins like this:
# JENKINS_HOST=username:password@myhost.com:port
# curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/' > jenkins_master/conf/plugins.txt

COPY conf/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')

# "For 2.x-derived images, you may also want to" - we're 2.0 dervied, so we want this
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# Put the log file into the log directory, which will be in the data volume
# Move the WAR out of the persisted jenkins data dir
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

USER root
# Copy scripts for Doxygen doc generation.
COPY ./bin/makeApiNav.sh ./bin/runDoxygen.sh /usr/local/bin/
RUN chown -R  root:jenkins /usr/local/bin/makeApiNav.sh && chmod 750 /usr/local/bin/makeApiNav.sh
RUN chown -R  root:jenkins /usr/local/bin/runDoxygen.sh && chmod 750 /usr/local/bin/runDoxygen.sh

USER jenkins

# TODO: Fix permissions on /var/run/docker.sock
# In most cases the current fixed gid=999 for docker group works.
#
# This crashed jenkins_nginx for unknown reasons.
# you might need to do something like:
# docker exec -it  -u root jenkinsdocker_jk_master_1 bash -c "chown root:docker /var/run/docker.sock"
# If "docker pull library/composer" fails in build pipeline.
# USER root
# COPY ./entrypoint.sh /usr/local/sbin/
# ENTRYPOINT ["entrypoint.sh"]
