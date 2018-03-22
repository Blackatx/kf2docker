# Download Debian Testing as Base Image(Change to Stable if you dont like Testing)
FROM debian:testing

MAINTAINER "Blackatx"
LABEL version ="0.1.3"

ENV DEBIAN_FRONTEND noninteractive

RUN \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install curl wget file bzip2 gzip unzip nano lib32gcc1 net-tools lib32stdc++6 && \
	apt-get clean && \
	rm -rf /var/cache/apk/*
	

## User Config
RUN adduser \
	--home /home/kf2 \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running steam" \
	--quiet \
kf2

RUN mkdir -p /home/kf2/steamcmd && \
    cd /home/kf2/steamcmd && \
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
	chown -R kf2 /home/kf2/steamcmd
	


ADD ./kf2start.sh /home/kf2/kf2start.sh
ADD ./main.sh /home/kf2/main.sh
RUN chmod 777 /home/kf2/main.sh

WORKDIR /home/kf2
USER kf2

# Steam port
EXPOSE 20560/udp

# Query port
EXPOSE 27015/udp

# Game port
EXPOSE 7777/udp

# Web Admin port
EXPOSE 8080/tcp

#NTP PORT
EXPOSE 123/udp


ENTRYPOINT [ "/main.sh" ]

