FROM linuxserver/baseimage
MAINTAINER Etienne Blondelle <etienneblondelle@gmail.com>

#Installing pyLoad
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list \
        && echo "deb-src http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list \
        && cat /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y python \
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
        && git clone https://github.com/mariusbaumann/pyload.git /opt/pyload \
        && echo "/opt/pyload/pyload-config" > /opt/pyload/module/config/configdir \
        && apt-get purge -y git \
        && apt-get autoremove -y \
        && apt-get clean -y

#Adding default config files
ADD config/ /tmp/pyload-config
ADD services/ /etc/service/

#Changing rights
RUN chmod -v 0755 /etc/service/* /etc/service/*/run

#Exposing ports and volumes
VOLUME /opt/pyload/Downloads
EXPOSE 8000
