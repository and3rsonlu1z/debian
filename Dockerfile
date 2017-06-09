FROM debian:jessie
MAINTAINER anderson@infraops.info

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get -qqy install openjdk-7-jre wget curl ca-certificates tzdata \
     nano wget rsyslog locales software-properties-common gosu --no-install-recommends \
  && ln -sf /usr/lib/jvm/java-7-openjdk-amd64/bin/java /usr/bin/ \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
  
RUN cd /usr/local/bin \
  && curl -sL $(curl -s https://api.github.com/repos/jwilder/dockerize/releases/latest \
    | grep -E 'browser_.*amd64' | cut -d\" -f4) | tar xzv \
  && chmod +x dockerize
  
CMD ["/bin/bash"]
