# Download Debian Testing as Base Image(Change to Stable if you dont like Testing)
FROM debian:testing

LABEL maintainer "Blackatx"

ENV DEBIAN_FRONTEND noninteractive

RUN \
	dpkg --add-architecture i386 && \
	apt-get -y update && \
	apt-get -y install mailutils \
						postfix \
						curl \
						wget \
						file \
						bzip2 \
						gzip \
						unzip \
						nano \
						bsdmainutils \
						python \
						util-linux \
						ca-certificates \
						binutils \
						bc \
						tmux \
						lib32gcc1 \
						libstdc++6 \
						libstdc++6:i386 && \
	apt-get clean && \
	rm -rf /var/cache/apk/*
	
## Get Linux GameServerManager
RUN wget https://linuxgsm.com/dl/linuxgsm.sh

## User Config (User:kf2sever)
RUN adduser -m --disabled-password --gecos "" kf2server && \
	chown kf2server:kf2server /linuxgsm.sh && \
	chmod +x /linuxgsm.sh && \
	cp /linuxgsm.sh /home/kf2server/linuxgsm.sh && \
	bash linuxgsm.sh kf2server

WORKDIR /home/kf2server
USER kf2server

#need to fake it linuxgsm
ENV TERM=xterm


ENV PATH=$PATH:/home/kf2server

COPY main.sh /main.sh

# Steam port
EXPOSE 20560/udp

# Query port - used to communicate with the master server
EXPOSE 27015/udp

# Game port - primary comms with players
EXPOSE 7777/udp

# Web Admin port
EXPOSE 8080/tcp

ENTRYPOINT [ "/main.sh" ]

