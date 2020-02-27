FROM debian:buster-slim
# set varFROM debian:buster-slimiables
# User/Group Id gui app will be executed as default are 99 and 100
#ENV USER_ID=99 GROUP_ID=100 APP_NAME="Mediathekview" WIDTH=1420 HEIGHT=840 TERM=xterm

RUN seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{}

RUN apt-get update
RUN apt-get install -qy mediathekview 
RUN apt-get install -y ffmpeg
RUN apt-get install -y wget

#RUN apt-get install -y x11-apps

RUN rm -rf /tmp/* /usr/share/doc/* /usr/share/info/* /var/tmp/*
RUN useradd -ms /bin/bash user
RUN chmod 777 /media 
RUN wget https://download.mediathekview.de/stabil/MediathekView-latest-linux.deb
RUN apt install ./MediathekView-latest-linux.deb
ENV DISPLAY :0
USER user

ENTRYPOINT ["/bin/sh", "-c", "$0 \"$@\"", "MediathekView -f"]
