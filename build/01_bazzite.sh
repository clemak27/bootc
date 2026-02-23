#!/bin/bash

set -ouex pipefail

dnf -y install podman-docker zsh
dnf -y remove ptyxis

# podman

mkdir -p /etc/containers
touch /etc/containers/nodocker

systemctl enable podman.socket

# change default shell

sed -i 's@/bin/bash@/bin/zsh@g' /etc/default/useradd

# signed image

mkdir -p /etc/pki/containers
cp /ctx/cosign.pub /etc/pki/containers/clemak27.pub

restorecon -RFv /etc/pki/containers
restorecon -RFv /etc/containers
