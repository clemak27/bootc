#!/bin/bash

set -ouex pipefail

# disable unused registries

sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/fedora-cisco-openh264.repo \
  /etc/yum.repos.d/google-chrome.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-steam.repo

RELEASE=$(rpm -E %fedora)

rpm-ostree install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm"

# packages

rpm-ostree uninstall firefox firefox-langpacks

rpm-ostree install \
  distrobox \
  gcc-c++ \
  kontact \
  ksshaskpass \
  podman-compose \
  podman-docker \
  steam-devices \
  vim \
  wl-clipboard \
  zsh

# podman

mkdir -p /etc/containers
touch /etc/containers/nodocker

systemctl enable podman.socket

# openrgb udev rules

curl -LO "https://openrgb.org/releases/release_0.9/60-openrgb.rules"
mv 60-openrgb.rules /etc/udev/rules.d/
restorecon /etc/udev/rules.d/60-openrgb.rules

# steam udev rules

curl -fLo /etc/udev/rules.d/60-steam-input.rules https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
restorecon /etc/udev/rules.d/60-steam-input.rules
curl -fLo /etc/udev/rules.d/60-steam-vr.rules https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
restorecon /etc/udev/rules.d/60-steam-vr.rules
