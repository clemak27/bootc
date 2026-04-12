#!/bin/bash

set -ouex pipefail

# copy system files into root

rsync -rvK /ctx/sys_files/ /

systemctl enable --global dotfiles-init.service
systemctl enable --global flatpak-preinstall.service

# disable unused codec repo

sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/fedora-cisco-openh264.repo

# add nonfree repos

RELEASE=$(rpm -E %fedora)

dnf -y install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm"

# setup flathub

mkdir -p /etc/flatpak/remotes.d/
curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

# packages

dnf -y remove \
  chrony \
  firefox \
  firefox-langpacks \
  sssd* \
  toolbox

dnf -y install \
  NetworkManager-openvpn \
  alsa-firmware \
  alsa-tools-firmware \
  audispd-plugins \
  distrobox \
  dnf-plugins-core \
  fprintd \
  fprintd-pam \
  gcc-c++ \
  git-credential-libsecret \
  gvfs-archive \
  gvfs-mtp \
  gvfs-nfs \
  iwlegacy-firmware \
  jmtpfs \
  libcamera-{v4l2,gstreamer,tools} \
  libratbag-ratbagd \
  libvirt \
  osbuild-selinux \
  pam_yubico \
  podman-compose \
  podman-docker \
  powerstat \
  qemu \
  switcheroo-control \
  tuned \
  tuned-ppd \
  vim \
  zsh

systemctl enable auditd
systemctl enable firewalld

# dns

tee /usr/lib/systemd/system-preset/91-resolved-default.preset << 'EOF'
enable systemd-resolved.service
EOF
tee /usr/lib/tmpfiles.d/resolved-default.conf << 'EOF'
L /etc/resolv.conf - - - - ../run/systemd/resolve/stub-resolv.conf
EOF

systemctl preset systemd-resolved.service

rm -f /usr/lib/systemd/system/flatpak-add-fedora-repos.service
systemctl enable enable-flathub.service
