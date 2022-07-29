FROM debian:latest

ARG PYCHARM_VERSION=2022.2
ARG PYCHARM_BUILD=2022.2
ARG pycharm_source=https://download.jetbrains.com/python/pycharm-community-${PYCHARM_BUILD}.tar.gz
ARG pycharm_local_dir=.PyCharmCE${PYCHARM_VERSION}

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install --no-install-recommends -y \
        python3 \
        python3-dev \
        python3-setuptools \
        python3-wheel \
        python3-pip \
        python3-requests \
        python3-bs4 \
        python3-openssl \
        python3-cryptography \
        python3-more-itertools \
        python3-dnspython \
        python3-yaml \
        python3-ipaddr \
        virtualenv \
        gcc \
        git \
        less \
        curl \
        unzip \
        libxtst-dev \
        libxrender-dev \
        libgtk-3-0 \
        libxslt1-dev \
        libxxf86vm-dev \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -ms /bin/bash developer

WORKDIR /opt/pycharm

RUN curl -fsSL $pycharm_source -o /opt/pycharm/installer.tgz \
  && echo "Please verify the hashsum over e.g. Tor: $(sha256sum /opt/pycharm/installer.tgz)" \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz

USER developer
ENV HOME /home/developer

RUN mkdir -p /home/developer/.cache/dconf

RUN mkdir /home/developer/.PyCharm \
  && ln -sf /home/developer/.PyCharm /home/developer/$pycharm_local_dir

CMD [ "/opt/pycharm/bin/pycharm.sh" ]
