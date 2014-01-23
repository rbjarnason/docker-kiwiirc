# kiwiIRC

FROM yrpri/base
MAINTAINER Robert Bjarnason <robert@citizens.is>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get install -y python-software-properties python
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -yqq install openssl git nodejs

RUN cd /root;git clone https://github.com/rbjarnason/KiwiIRC.git
RUN cd /root;openssl genrsa -out server.key
RUN cd /root;openssl req -subj '/C=IS/ST=Reykjavik/L=Iceland/CN=irc.yrpri.org' -new -key server.key -out csr.pem
RUN cd /root;openssl x509 -req  -days 9999 -in csr.pem -signkey server.key -out cert.pem
RUN cd /root;rm csr.pem

ADD supervisor.conf /etc/supervisor/conf.d/kiwiirc.conf

EXPOSE 7778

CMD ["/usr/bin/supervisord"]








-subj '/C=US/ST=Oregon/L=Portland/CN=www.madboa.com'