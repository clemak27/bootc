#!/bin/bash

set -ouex pipefail

# copy system files into root

rsync -rvK /ctx/sys_files/ /

systemctl enable --global dotfiles-init.service
systemctl enable --global flatpak-preinstall.service

# add nonfree repos

RELEASE=$(rpm -E %fedora)

dnf -y install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm"

# setup flathub

mkdir -p /etc/flatpak/remotes.d/
curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo

# disable unused repos

sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
  /etc/yum.repos.d/fedora-cisco-openh264.repo \
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
systemctl enable fp-preinstall.service

# podman

mkdir -p /etc/containers
touch /etc/containers/nodocker

systemctl enable podman.socket

# change default shell

sed -i 's@/bin/bash@/bin/zsh@g' /etc/default/useradd

# brew

# renovate: datasource=github-tags depName=Homebrew/brew versioning=loose
brew_version="5.1.5"
curl -fL -o /usr/share/homebrew.tar.gz https://github.com/Homebrew/brew/archive/refs/tags/$brew_version.tar.gz

systemctl enable brew-setup.service
cat << EOF > /etc/zshenv
HOMEBREW_CELLAR=/var/home/linuxbrew/.linuxbrew/Cellar
HOMEBREW_NO_ANALYTICS=1
HOMEBREW_PREFIX=/var/home/linuxbrew/.linuxbrew
HOMEBREW_REPOSITORY=/var/home/linuxbrew/.linuxbrew/Homebrew
PATH="/var/home/linuxbrew/.linuxbrew/bin:$PATH"
EOF
