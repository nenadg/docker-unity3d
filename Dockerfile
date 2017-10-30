FROM ubuntu:xenial
MAINTAINER me@nenadg.com

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
  apt-get -qq update && apt-get -qq install -y \
  git \
  imagemagick \
  curl \
  wget \
  gconf-service \
  lib32gcc1 \
  lib32stdc++6 \
  libasound2 \
  libc6 \
  libc6-i386 \
  libcairo2 \
  libcap2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libfreetype6 \
  libgcc1 \
  libgconf-2-4 \
  libgdk-pixbuf2.0-0 \
  libgl1-mesa-glx \
  libglib2.0-0 \
  libglu1-mesa \
  libgtk2.0-0 \
  libnspr4 \
  libnss3 \
  libpango1.0-0 \
  libstdc++6 \
  libx11-6 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxtst6 \
  zlib1g \
  debconf \
  npm \
  xdg-utils \
  lsb-release \
  libpq5 \
  xvfb \
  python-yaml \
  python-pip \
  python-dev \
  build-essential \
  virtualenv \
  python \
  x11vnc \
  xvfb \
  sudo \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -u 12345 -g users -d /home/adminuser -s /bin/bash -p $(echo 1234 | openssl passwd -1 -stdin) adminuser

# updated list of versions https://forum.unity.com/threads/unity-on-linux-release-notes-and-known-issues.350256/page-2
# version used in this container: http://beta.unity3d.com/download/8bc04e1c171e/unity-editor_amd64-5.6.0xf3Linux.deb
# 2017.2 (latest): http://beta.unity3d.com/download/ee86734cf592/unity-editor_amd64-2017.2.0f3.deb
# N.B. in 2017.2 you can use --username [your username] --password [pass] --serial to activate seamlessly without
# having to vnc to container
RUN mkdir -p /home/adminuser/.cache/unity3d && mkdir -p /home/adminuser/.local/share/unity3d/Unity && \
  mkdir -p /home/adminuser/.local/share/unity3d/Certificates && \
  curl -O http://beta.unity3d.com/download/8bc04e1c171e/unity-editor_amd64-5.6.0xf3Linux.deb && \
  dpkg -i /unity-editor_amd64-5.6.0xf3Linux.deb

ENV PATH "/opt/Unity/Editor/:${PATH}"

EXPOSE 5900 5555

RUN chmod 4755 /opt/Unity/Editor/chrome-sandbox && \
  chown -R adminuser:users /home/adminuser

RUN echo 'adminuser ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

ADD /entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER adminuser

WORKDIR /home/adminuser

ENTRYPOINT ["/entrypoint.sh"]
