#FROM ubuntu:eoan
FROM debian:buster-slim
# set varFROM debian:buster-slimiables
# User/Group Id gui app will be executed as default are 99 and 100
#ENV USER_ID=99 GROUP_ID=100 APP_NAME="Mediathekview" WIDTH=1420 HEIGHT=840 TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

RUN seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{}

RUN apt-get update
RUN apt-get install -qy mediathekview 
RUN apt-get install -y ffmpeg
RUN apt-get install -y wget

RUN rm -rf /tmp/* /usr/share/doc/* /usr/share/info/* /var/tmp/*
RUN useradd -ms /bin/bash user
RUN chmod 777 /media 
RUN wget https://download.mediathekview.de/stabil/MediathekView-latest-linux.deb
RUN apt install ./MediathekView-latest-linux.deb
RUN apt-get install -y x11vnc

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html
RUN wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.9.0 /root/novnc/utils/websockify
RUN apt-get install -y supervisor 
RUN apt-get install -y xvfb fluxbox
ENV DISPLAY :0

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 8080
#USER user
CMD ["/usr/bin/supervisord"]

#CMD ["/usr/local/bin/MediathekView"]
#ENTRYPOINT ["/bin/sh", "-c", "$0 \"$@\"", "MediathekView -f"]
