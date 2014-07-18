# Ruby (https://www.ruby-lang.org/en/)

FROM ubuntu:trusty
MAINTAINER Ilia Lobsanov <ilia@nurey.com>
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
  echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install packages required for rvm
RUN apt-get -y install sudo python-software-properties wget openssl libreadline6 \
      libreadline6-dev curl git zlib1g zlib1g-dev libyaml-dev \
      libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev \
      ncurses-dev automake libtool bison subversion zlib1g-dev \
      build-essential libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev \
      gawk openjdk-7-jre-headless libssl-dev libgdbm-dev pkg-config libffi-dev

# Create user for rvm
RUN adduser --disabled-password --home=/ilia --gecos "" ilia

# Install rvm
RUN su ilia -c "curl -sSL https://get.rvm.io | bash" 
#  su ilia -c echo "source /ilia/.rvm/scripts/rvm" >> /ilia/.bash_profile
#ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#RUN source /usr/local/rvm/scripts/rvm
#RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
#RUN /bin/bash -l -c "rvm requirements"

# Install ruby
RUN su - ilia -c "rvm install ruby-2.1.2"

# Install jruby
RUN su - ilia -c "rvm install jruby-1.7.13"

# Use jruby
RUN su - ilia -c "rvm use jruby --default"

# Install bundler
RUN su - ilia -c 'gem install bundler'
