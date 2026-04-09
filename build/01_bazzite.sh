#!/bin/bash

set -ouex pipefail

dnf -y install podman-docker zsh
dnf -y remove ptyxis
