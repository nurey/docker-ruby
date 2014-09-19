# Ruby (https://www.ruby-lang.org/en/)

FROM ubuntu:trusty
MAINTAINER Ilia Lobsanov <ilia@nurey.com>
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
  echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list && \
  apt-get update -qq && \
  apt-get -y upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install packages required for rvm
RUN apt-get -y install sudo software-properties-common unzip \
      python-software-properties wget openssl libreadline6 \
      libreadline6-dev curl git zlib1g zlib1g-dev libyaml-dev \
      libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev \
      ncurses-dev automake libtool bison subversion zlib1g-dev \
      build-essential libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev \
      gawk openjdk-7-jre-headless libssl-dev libgdbm-dev pkg-config libffi-dev \
      ca-certificates 

# Install Oracle Java 8
RUN cd /tmp \
    && wget -O jdk8.tar.gz \
       --header "Cookie: oraclelicense=accept-securebackup-cookie" \
       http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz \
    && tar xzf jdk8.tar.gz -C /opt \
    && mv /opt/jdk* /opt/java \
    && rm /tmp/jdk8.tar.gz \
    && update-alternatives --install /usr/bin/java java /opt/java/bin/java 2000 \
    && update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 2000

# Install Java Cryptography Extension Unlimited Strength Policy files
RUN cd /tmp \
    && wget \
       --header "Cookie: oraclelicense=accept-securebackup-cookie" \
       http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
    && unzip jce_policy-8.zip \
    && mv UnlimitedJCEPolicyJDK8/*.jar /opt/java/jre/lib/security/

ENV JAVA_HOME /opt/java

# Install nodejs and npm
RUN add-apt-repository ppa:chris-lea/node.js && \
      apt-get update -qq && apt-get -y install nodejs 

# Create user for rvm
RUN adduser --disabled-password --home=/ilia --gecos "" ilia

# Install rvm
RUN su ilia -c "curl -sSL https://get.rvm.io | bash" 
#  su ilia -c echo "source /ilia/.rvm/scripts/rvm" >> /ilia/.bash_profile
#ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#RUN source /usr/local/rvm/scripts/rvm
#RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
#RUN /bin/bash -l -c "rvm requirements"

# Install ca certificates
RUN su ilia -c "wget -O /ilia/cacert.pem http://curl.haxx.se/ca/cacert.pem"
RUN echo "export SSL_CERT_FILE=/ilia/cacert.pem" >> /ilia/.bash_profile
ENV SSL_CERT_FILE /ilia/cacert.pem

# Install ruby
RUN su - ilia -c "rvm install ruby-2.1.3"

# Install jruby
RUN su - ilia -c "rvm install jruby-1.7.15"

# Use jruby
RUN su - ilia -c "rvm use jruby-1.7.15 --default"

# Install bundler
RUN su - ilia -c "gem install bundler"

# Install bower
RUN npm install bower -g
