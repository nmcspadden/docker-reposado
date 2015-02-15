# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM nginx:latest

MAINTAINER Nick McSpadden "nmcspadden@gmail.com"

RUN apt-get update && apt-get install -y curl python

ADD preferences.plist /reposado/code/
ADD nginx.conf /etc/nginx/nginx.conf
ADD reposado.conf /etc/nginx/sites-enabled/reposado.conf
ADD https://github.com/wdas/reposado/tarball/master /master.tar.gz
RUN tar -xvzf /master.tar.gz --strip-components=1 -C /reposado/ && rm /master.tar.gz

VOLUME /reposado/html
VOLUME /reposado/metadata

RUN rm -f /etc/nginx/sites-enabled/default && rm -f /etc/service/nginx/down
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
