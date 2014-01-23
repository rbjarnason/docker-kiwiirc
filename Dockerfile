# kiwiIRC

FROM yrpri/base
MAINTAINER Robert Bjarnason <robert@citizens.is>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get install -y python-software-properties python
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -yqq install git nodejs

RUN cd /root;git clone https://github.com/rbjarnason/KiwiIRC.git

ADD supervisor.conf /etc/supervisor/conf.d/kiwiirc.conf

EXPOSE 7778

CMD ["/usr/bin/supervisord"]