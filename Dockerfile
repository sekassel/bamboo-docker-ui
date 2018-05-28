FROM atlassian/bamboo-java-agent

RUN apt-get update && apt-get install -y \
  python-software-properties \
  software-properties-common \
  openssh-client

RUN add-apt-repository ppa:linuxuprising/java && \
  apt-get update && \
  apt-get install -y oracle-java10-installer

RUN echo 2 | update-alternatives --config java && \
  echo 2 | update-alternatives --config javac
