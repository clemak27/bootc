#!/bin/bash

set -ouex pipefail

# copy systemd-user files

rsync -rvK /ctx/sys_files/usr/lib/systemd/user /usr/lib/systemd
rsync -rvK /ctx/sys_files/usr/lib/systemd/user-preset /usr/lib/systemd

systemctl enable --global dotfiles-init.service

dnf -y install podman-docker zsh
dnf -y remove ptyxis
