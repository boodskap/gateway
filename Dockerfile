FROM node

MAINTAINER platform@boodskap.io

LABEL Remarks="Preconfigured Nginx Server for Boodskap IoT Platform"

RUN apt-get update
RUN apt-get -y --fix-missing install nginx
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
RUN git fetch --all --tags
RUN git checkout tags/v3.0.20
RUN npm install
RUN node build.js

RUN rm -f /etc/nginx/sites-enabled/default

EXPOSE 80 443

CMD ["/start-gateway.sh"]
