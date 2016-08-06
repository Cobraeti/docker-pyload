FROM linuxserver/baseimage
MAINTAINER Etienne Blondelle <etienneblondelle@gmail.com>

#Installing pyLoad
RUN apt-get update && apt-get -y install --no-install-recommends python python-pycurl python-crypto tesseract-ocr python-beaker python-imaging unrar gocr python-django python-openssl python-pyxmpp git rhino
RUN git clone https://github.com/pyload/pyload.git && echo "/pyload/config" > /pyload/module/config/configdir && mkdir /pyload/config /pyload/downloads

#Adding default config files and services
ADD config/ /tmp/config/
ADD services/ /etc/service/

#Changing rights
RUN chmod -v 0755 /etc/service/* /etc/service/*/run

#Exposing ports and volumes
VOLUME /pyload/config /pyload/downloads
EXPOSE 8000
