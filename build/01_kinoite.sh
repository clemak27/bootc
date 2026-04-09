#!/bin/bash

set -ouex pipefail

# disable unused repos

sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-steam.repo

# packages

dnf -y remove \
  firefox \
  firefox-langpacks \
  konsole \
  toolbox

dnf -y install \
  distrobox \
  gcc-c++ \
  ksshaskpass \
  libvirt \
  openrgb-udev-rules \
  osbuild-selinux \
  podman-compose \
  podman-docker \
  qemu \
  steam-devices \
  vim \
  wl-clipboard \
  zsh

# flathub

rm -f /usr/lib/systemd/system/flatpak-add-fedora-repos.service
systemctl enable enable-flathub.service

# podman

mkdir -p /etc/containers
touch /etc/containers/nodocker

systemctl enable podman.socket

# change default shell

sed -i 's@/bin/bash@/bin/zsh@g' /etc/default/useradd

# brew

systemctl enable brew-setup.service
cat << EOF > /etc/zshenv
HOMEBREW_CELLAR=/var/home/linuxbrew/.linuxbrew/Cellar
HOMEBREW_NO_ANALYTICS=1
HOMEBREW_PREFIX=/var/home/linuxbrew/.linuxbrew
HOMEBREW_REPOSITORY=/var/home/linuxbrew/.linuxbrew/Homebrew
PATH="/var/home/linuxbrew/.linuxbrew/bin:$PATH"
EOF
