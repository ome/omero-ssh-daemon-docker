#!/bin/bash

set -e -u -x

PRIVILEGED=""
VOLUMES=""
# start docker container
if [[ "darwin" == "${OSTYPE//[0-9.]/}" ]]; then
    PRIVILEGED="--privileged"
fi

make start PORTS=$PRIVILEGED
docker inspect -f {{.State.Running}} omero-ssh-daemon

# CLEANUP
make stop
make rm
