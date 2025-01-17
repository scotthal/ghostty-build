FROM ubuntu:latest

ARG USER_USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update; \
  apt-get -y install curl git sudo xz-utils; \
  groupadd --gid $USER_GID $USER_USERNAME; \
  useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_USERNAME; \
  echo $USER_USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_USERNAME; \
  chmod 0440 /etc/sudoers.d/$USER_USERNAME; \
  apt-get -y clean; \
  rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

USER $USER_USERNAME
ENV USER=$USER_USERNAME
WORKDIR /home/$USER_USERNAME

RUN curl -L https://nixos.org/nix/install > /home/$USER_USERNAME/install-nix.sh; \
  sh /home/$USER_USERNAME/install-nix.sh --no-daemon;

COPY ./ghostty-build.sh ./ghostty-build.sh

CMD ["/bin/sh", "./ghostty-build.sh"]

