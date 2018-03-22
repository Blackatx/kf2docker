# Download Debian Testing as Base Image(Change to Stable if you dont like Testing)
FROM debian:testing

MAINTAINER "Blackatx"
LABEL version ="0.1.2.2203181348"

ENV DEBIAN_FRONTEND noninteractive
ENV USER kf2
ENV HOME /home/$USER
ENV STEAMCMD $HOME/steamcmd

RUN \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install curl wget file bzip2 gzip unzip nano lib32gcc1 net-tools lib32stdc++6 && \
	apt-get clean && \
	rm -rf /var/cache/apk/*
	

## User Config
RUN adduser \
	--home $HOME \
	--disabled-password \
	--shell /bin/bash \
	--gecos "user for running steam" \
	--quiet \
$USER

RUN mkdir -p /steamcmd && \
    cd /steamcmd && \
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
	chown -R $USER /steamcmd
	


ADD ./kf2start.sh $HOME/kf2start.sh
ADD ./main.sh $HOME/main.sh
RUN chown $USER $HOME/main.sh

WORKDIR $HOME
USER $USER

RUN $HOME/main.sh $HOME $STEAMCMD


# Steam port
EXPOSE 20560/udp

# Query port - used to communicate with the master server
EXPOSE 27015/udp

# Game port - primary comms with players
EXPOSE 7777/udp

# Web Admin port
EXPOSE 8080/tcp

#NTP PORT
EXPOSE 123/UDP


ENTRYPOINT [ "/kf2start.sh" ]

