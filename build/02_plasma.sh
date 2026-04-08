#!/bin/bash

set -ouex pipefail

dnf -y install git cmake extra-cmake-modules gettext

## packages

dnf -y copr enable scottames/ghostty
dnf -y copr enable ama1470/kwin-effects-glass
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:paulmcauley/Fedora_43/home:paulmcauley.repo

dnf -y install \
  adw-gtk3-theme \
  ghostty \
  klassy \
  kwin-effects-glass \
  papirus-icon-theme

dnf -y remove \
  konsole

rm -f /etc/yum.repos.d/home:paulmcauley.repo
dnf -y copr disable ama1470/kwin-effects-glass
dnf -y copr disable scottames/ghostty

## plasmoids

# renovate: datasource=github-tags depName=peterfajdiga/karousel versioning=loose
karousel_version=0.16

cd /tmp
curl -fL -o /tmp/karousel.tar.gz https://github.com/peterfajdiga/karousel/releases/download/v$karousel_version/karousel_"${karousel_version/"."/"_"}".tar.gz
tar xzf /tmp/karousel.tar.gz
mkdir -p "/usr/share/kwin/scripts/karousel"
mv /tmp/karousel/* "/usr/share/kwin/scripts/karousel"

# plasma-panel-colorizer

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-colorizer versioning=loose
panel_colorizer_version=6.10.0
panel_colorizer_plasmoid=plasmoid-panel-colorizer-v$panel_colorizer_version.plasmoid

cd /tmp
curl -fL -o /tmp/pc.plasmoid https://github.com/luisbocanegra/plasma-panel-colorizer/releases/download/v$panel_colorizer_version/$panel_colorizer_plasmoid
unzip /tmp/pc.plasmoid -d /tmp/pc
mkdir -p "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"
mv /tmp/pc/* "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"

# plasma-panel-spacer-extended

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-spacer-extended versioning=loose
panelspacer_extended_version=1.15.0
panelspacer_extended_plasmoid=plasmoid-spacer-extended-v$panelspacer_extended_version.plasmoid

cd /tmp
curl -fL -o /tmp/ps.plasmoid https://github.com/luisbocanegra/plasma-panel-spacer-extended/releases/download/v$panelspacer_extended_version/$panelspacer_extended_plasmoid
unzip /tmp/ps.plasmoid -d /tmp/ps
mkdir -p "/usr/share/plasma/plasmoids/luisbocanegra.panelspacer.extended"
mv /tmp/ps/* "/usr/share/plasma/plasmoids/luisbocanegra.panelspacer.extended"

# kwin4_effect_geometry_change

# renovate: datasource=github-tags depName=peterfajdiga/kwin4_effect_geometry_change versioning=loose
geometry_version=1.5
geometry_tar=kwin4_effect_geometry_change_1_5.tar.gz

cd /tmp
curl -fL -o /tmp/kgc.tar.gz https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v$geometry_version/$geometry_tar
tar xzf /tmp/kgc.tar.gz
mkdir -p "/usr/share/kwin/effects"
mv /tmp/kwin4_effect_geometry_change "/usr/share/kwin/effects/kwin4_effect_geometry_change"
