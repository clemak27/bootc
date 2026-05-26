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
