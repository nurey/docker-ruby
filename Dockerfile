# Ruby (https://www.ruby-lang.org/en/)

FROM ubuntu:trusty
MAINTAINER Ilia Lobsanov <ilia@nurey.com>
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install curl
RUN apt-get install -y curl

# Install rvm
RUN apt-get -y install python-software-properties wget openssl libreadline6 \
      libreadline6-dev curl git zlib1g zlib1g-dev libyaml-dev \
      libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev 
      ncurses-dev automake libtool bison subversion zlib1g-dev 
      build-essential libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev
RUN \curl -sSL https://get.rvm.io | bash
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#RUN source /usr/local/rvm/scripts/rvm
#RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
#RUN /bin/bash -l -c "rvm requirements"

# Install ruby
#RUN rvm install ruby-2.1.2

# Install jruby
RUN rvm install jruby-1.7.13

