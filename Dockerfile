###
#
# contains code by Sam Giles (https://github.com/samgiles/docker-xvfb/blob/master/Dockerfile)
# and dex
#
# MIT license
#
###

# pull base image
FROM atlassian/bamboo-java-agent

RUN apt-get update
RUN sudo apt-get  install -y xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps

ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
ADD xvfb_daemon_run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run

ENV DISPLAY :99

RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb http://ftp.de.debian.org/debian jessie main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    apt-get install -y --force-yes gtk2-engines libxtst6 libxxf86vm1 freeglut3 libxslt1.1 && \
    apt-get update  && \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*
