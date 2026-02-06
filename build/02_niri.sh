#!/bin/bash

set -ouex pipefail

dnf -y copr enable avengemedia/dms
dnf -y copr enable scottames/ghostty

dnf -y install \
  brightnessctl \
  cava \
  ddcutil \
  dgop \
  dms \
  dms-cli \
  dms-greeter \
  dsearch \
  fpaste \
  gcr \
  ghostty \
  glycin-thumbnailer \
  gnome-disk-utility \
  gnome-keyring \
  gnome-keyring-pam \
  greetd \
  greetd-selinux \
  kdeconnectd \
  matugen \
  nautilus \
  nautilus-python \
  niri \
  openrgb-udev-rules \
  openssh-askpass \
  pipewire \
  playerctl \
  quickshell \
  steam-devices \
  udiskie \
  webp-pixbuf-loader \
  wireplumber \
  wl-clipboard \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  xdg-terminal-exec \
  xdg-user-dirs \
  xwayland-satellite

dnf -y remove \
  alacritty

dnf install -y --setopt=install_weak_deps=False \
  kf6-kirigami \
  qt6ct \
  plasma-breeze \
  breeze-cursor-theme \
  kf6-qqc2-desktop-style

dnf install -y \
  default-fonts-core-emoji \
  google-noto-color-emoji-fonts \
  google-noto-emoji-fonts \
  google-noto-sans-fonts \
  glibc-all-langpacks \
  default-fonts

systemctl enable --global dms.service
systemctl enable --global gnome-keyring-daemon.service
systemctl enable --global gnome-keyring-daemon.socket

systemctl enable greetd
systemctl enable firewalld
systemctl enable brew-setup.service

# improve fingerprint auth
install -Dpm0644 -t /usr/lib/pam.d/ /usr/share/quickshell/dms/assets/pam/*
sed --sandbox -i -e '/gnome_keyring.so/ s/-auth/auth/ ; /gnome_keyring.so/ s/-session/session/' /etc/pam.d/greetd

# greeter service user
tee /usr/lib/sysusers.d/greeter.conf << 'EOF'
g greeter 767
u greeter 767 "Greetd greeter"
EOF

tee /usr/lib/systemd/user-preset/02-gcr-ssh.preset << 'EOF'
enable gcr-ssh-agent.socket
EOF

dnf -y copr disable avengemedia/dms
dnf -y copr disable scottames/ghostty
