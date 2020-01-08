FROM boodskapiot/ubuntu:18.04

MAINTAINER platform@boodskap.io

LABEL Remarks="Preconfigured Nginx Server for Boodskap IoT Platform"

RUN apt-get update
RUN apt-get -y --fix-missing install tar curl net-tools nano wget unzip rsyslog psmisc netcat nginx nodejs npm
RUN npm install pm2
RUN apt-get clean && apt-get autoclean && apt-get autoremove

WORKDIR /

COPY etc/ /etc/
COPY root/ /root/
COPY start-gateway.sh .

RUN chmod +x start-gateway.sh

RUN mkdir -p /root/webapps
WORKDIR /root/webapps
RUN git clone https://github.com/BoodskapPlatform/boodskap-ui.git

WORKDIR /root/webapps/boodskap-ui
RUN npm install
RUN node build.js

RUN rm -f /etc/nginx/sites-enabled/default

EXPOSE 80 443

CMD ["/start-gateway.sh"]
