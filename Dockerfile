FROM atlassian/bamboo-java-agent

RUN apt-get update && apt-get install -y \
  python-software-properties \
  software-properties-common \
  openssh-client

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | \
    sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | \
    sudo debconf-set-selections

RUN add-apt-repository ppa:linuxuprising/java && \
  apt-get update && \
  apt-get install -y oracle-java10-installer

COPY run-agent.sh /root/
