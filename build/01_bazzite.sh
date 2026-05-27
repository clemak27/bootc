#!/bin/bash

set -ouex pipefail

# copy systemd-user files

rsync -rvK /ctx/sys_files/usr/lib/systemd/user /usr/lib/systemd
rsync -rvK /ctx/sys_files/usr/lib/systemd/user-preset /usr/lib/systemd
rsync -rvK /ctx/sys_files/usr/lib/systemd/system/nix.mount /usr/lib/systemd/system/nix.mount

systemctl enable --global dotfiles-init.service
systemctl enable --global flatpak-preinstall.service

dnf -y install podman-docker zsh
dnf -y remove ptyxis

# nix

systemctl enable nix.mount
dnf -y install nix nix-daemon
systemctl enable nix-daemon.service
cat << EOF > /etc/nix/nix.conf
auto-optimise-store = true
experimental-features = nix-command flakes
extra-nix-path = nixpkgs=flake:nixpkgs
extra-platforms = aarch64-linux
extra-sandbox-paths = /usr/bin/qemu-aarch64-static
max-jobs = auto
ssl-cert-file = /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
EOF
