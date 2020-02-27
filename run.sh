#!/bin/bash
setfacl -m user:1000:r ${HOME}/.Xauthority
exec docker run \
    -it \
    --rm \
    --name mediathekview \
    --net=host \
    -e DISPLAY \
    -v user:/home/user/ \
    -v media:/media/ \
    mediathekview \
