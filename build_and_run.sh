#!/bin/bash
#docker volume create mediathek
#docker volume create media
#docker volume inspect mediathek
#docker volume inspect media
setfacl -m user:1000:r ${HOME}/.Xauthority
docker build -t mediathekview .
exec docker run \
    -it \
    --rm \
    --name mediathekview \
    --net=host \
    -e DISPLAY \
    -v user:/home/user/ \
    -v media:/media/ \
    mediathekview \
    "$@"
