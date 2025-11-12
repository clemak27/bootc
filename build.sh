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

dnf -y install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm"

# packages

dnf -y remove \
  firefox \
  firefox-langpacks \
  toolbox

dnf -y install \
  distrobox \
  gcc-c++ \
  kontact \
  ksshaskpass \
  openrgb-udev-rules \
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

# change default shell

sed -i 's@/bin/bash@/bin/zsh@g' /etc/default/useradd

# signed image

cat << EOF > /etc/containers/policy.json
{
  "default": [
    {
      "type": "reject"
    }
  ],
  "transports": {
    "docker": {
      "ghcr.io/clemak27": [
        {
          "type": "sigstoreSigned",
          "keyPath": "/etc/pki/containers/clemak27.pub",
          "signedIdentity": {
            "type": "matchRepository"
          }
        }
      ],
      "registry.access.redhat.com": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release"
        }
      ],
      "registry.redhat.io": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release"
        }
      ],
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "containers-storage": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "docker-daemon": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "oci": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "oci-archive": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    }
  }
}
EOF

mkdir -p /etc/containers/registries.d
cat << EOF > /etc/containers/registries.d/ghcr.yaml
docker:
  ghcr.io/clemak27:
    use-sigstore-attachments: true
EOF

mkdir -p /etc/pki/containers
cp /tmp/cosign.pub /etc/pki/containers/clemak27.pub

restorecon -RFv /etc/pki/containers
restorecon -RFv /etc/containers
