OMERO ssh daemon CentOS 7
=========================

### Creating your own Docker image

    make

### Run:

    UNIX:

        make start

    OSX:

        make start PORTS="--privileged"


### Test:

    ./runtest.sh