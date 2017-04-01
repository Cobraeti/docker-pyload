FROM linuxserver/baseimage
MAINTAINER Etienne Blondelle <etienneblondelle@gmail.com>

#Installing pyLoad
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
RUN cat /etc/apt/sources.list
RUN apt-get update && apt-get install -y python \
        python-pycurl \
        python-crypto \
        tesseract-ocr \
        python-beaker \
        python-imaging \
        unrar \
        gocr \
        python-django \
        git \
        rhino \
        && apt-get clean
RUN git clone https://github.com/mariusbaumann/pyload.git /opt/pyload
RUN echo "/opt/pyload/pyload-config" > /opt/pyload/module/config/configdir

#Adding default config files
ADD config/ /tmp/pyload-config
ADD services/ /etc/service/

#Changing rights
RUN chmod -v 0755 /etc/service/* /etc/service/*/run

#Exposing ports and volumes
VOLUME /opt/pyload/pyload-config
VOLUME /opt/pyload/Downloads
EXPOSE 8000
