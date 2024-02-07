OMERO ssh daemon Rocky Linux 9
==============================

[![Actions Status](https://github.com/ome/omero-ssh-daemon-docker/workflows/Build/badge.svg)](https://github.com/ome/omero-ssh-daemon-docker/actions)

### Creating your own Docker image

    make

### Run:

    UNIX:

        make start

    OSX:

        make start PORTS="--privileged"


### Test:

    ./runtest.sh
