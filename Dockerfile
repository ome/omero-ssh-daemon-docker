FROM rockylinux:9
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN dnf install -y sudo

# sshd
RUN dnf -y install openssh-server openssh-clients; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    rm -f /run/nologin; \
    dnf clean all;

RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd';\
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

RUN echo "root ALL= (ALL) ALL" >> /etc/sudoers

RUN useradd omero && \
    echo 'omero:omero' | chpasswd omero &&\
    echo "%omero ALL= (ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV ROOT_PASSWORD root

EXPOSE 22
ENTRYPOINT ["entry_point.sh"]
CMD ["/usr/sbin/sshd", "-eD"]
