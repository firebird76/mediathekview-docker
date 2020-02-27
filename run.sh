#!/bin/bash
exec docker run \
    -it \
    --rm \
    --name mediathekview \
    --net=host \
    -e DISPLAY \
    -v user:/home/user/ \
    -v media:/media/ \
    mediathekview \
