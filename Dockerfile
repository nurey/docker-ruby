# Ruby (https://www.ruby-lang.org/en/)

FROM ubuntu:saucy
MAINTAINER Ilia Lobsanov <ilia@nurey.com>
RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install rvm
RUN \curl -sSL https://get.rvm.io | bash
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN source /usr/local/rvm/scripts/rvm
RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
RUN /bin/bash -l -c "rvm requirements"

# Install ruby
RUN rvm install ruby-2.1.0

# Install jruby
RUN rvm install jruby-1.7.10

