#!/bin/bash

set -ouex pipefail

dnf -y copr enable avengemedia/dms
dnf -y copr enable scottames/ghostty

dnf -y install \
  adw-gtk3-theme \
  brightnessctl \
  cava \
  cups-pk-helper \
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
  papirus-icon-theme \
  pipewire \
  playerctl \
  quickshell-git \
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

rm -rf /usr/share/doc/niri

dnf -y remove \
  alacritty

dnf install -y --setopt=install_weak_deps=False \
  breeze-cursor-theme \
  kf6-kimageformats \
  kf6-kirigami \
  kf6-qqc2-desktop-style \
  plasma-breeze \
  qt6ct

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

systemctl enable --global niri-init.service
systemctl enable --global gcr-ssh-agent.socket
systemctl enable --global gcr-ssh-agent.service

dnf -y copr disable avengemedia/dms
dnf -y copr disable scottames/ghostty
