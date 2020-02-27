#!/bin/bash
#docker volume create mediathek
#docker volume create media
#docker volume inspect mediathek
#docker volume inspect media
setfacl -m user:1000:r ${HOME}/.Xauthority
docker build -t mediathekview .
exec docker run \
    -p 8080:8080 \  
    --name mediathekview \     
    -v user:/home/user/ \
    -v media:/media/ \
    mediathekview 

