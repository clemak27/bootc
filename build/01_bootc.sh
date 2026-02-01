#!/bin/bash

set -ouex pipefail

systemctl enable systemd-timesyncd
systemctl enable systemd-resolved.service

dnf -y install 'dnf5-command(config-manager)'
dnf -y install 'dnf5-command(copr)'

# packages

dnf -y remove \
  console-login-helper-messages \
  chrony \
  sssd* \
  toolbox

dnf -y install \
  -x PackageKit* \
  NetworkManager \
  NetworkManager-adsl \
  NetworkManager-bluetooth \
  NetworkManager-config-connectivity-fedora \
  NetworkManager-libnm \
  NetworkManager-openconnect \
  NetworkManager-openvpn \
  NetworkManager-strongswan \
  NetworkManager-ssh \
  NetworkManager-ssh-selinux \
  NetworkManager-vpnc \
  NetworkManager-wifi \
  NetworkManager-wwan \
  alsa-firmware \
  alsa-sof-firmware \
  alsa-tools-firmware \
  atheros-firmware \
  audispd-plugins \
  audit \
  brcmfmac-firmware \
  cifs-utils \
  cups \
  cups-pk-helper \
  distrobox \
  dnf-plugins-core \
  dymo-cups-drivers \
  firewalld \
  flatpak \
  fprintd \
  fprintd-pam \
  fuse \
  fuse-common \
  fwupd \
  gcc-c++ \
  git-core \
  git-credential-libsecret \
  gum \
  gvfs-archive \
  gvfs-mtp \
  gvfs-nfs \
  gvfs-smb \
  hplip \
  ibus \
  ifuse \
  intel-audio-firmware \
  iwlegacy-firmware \
  iwlwifi-dvm-firmware \
  iwlwifi-mvm-firmware \
  jmtpfs \
  kernel-modules-extra \
  libcamera{,-{v4l2,gstreamer,tools}} \
  libimobiledevice \
  libimobiledevice-utils \
  libratbag-ratbagd \
  man-db \
  man-pages \
  mobile-broadband-provider-info \
  mt7xxx-firmware \
  nxpwireless-firmware \
  openconnect \
  pam_yubico \
  pcsc-lite \
  plymouth \
  plymouth-system-theme \
  podman-compose \
  podman-docker \
  powerstat \
  printer-driver-brlaser \
  ptouch-driver \
  realtek-firmware \
  switcheroo-control \
  system-config-printer-libs \
  system-config-printer-udev \
  systemd-container \
  systemd-oomd-defaults \
  thermald \
  tiwilink-firmware \
  tuned \
  tuned-ppd \
  unzip \
  usb_modeswitch \
  uxplay \
  vim \
  vpnc \
  wget \
  whois \
  wireguard-tools \
  wl-clipboard \
  zram-generator-defaults \
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
