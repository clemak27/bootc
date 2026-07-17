#!/bin/bash

set -ouex pipefail

dnf -y install git cmake extra-cmake-modules gettext

## packages

dnf -y copr enable scottames/ghostty
dnf -y copr enable ama1470/kwin-effects-glass
dnf config-manager addrepo --from-repofile="https://download.opensuse.org/repositories/home:paulmcauley/Fedora_$(rpm -E %fedora)/home:paulmcauley.repo"

### kwin-effects-glass

# renovate: datasource=github-tags depName=4v3ngR/kwin-effects-glass versioning=loose
kwin_effects_glass_version=20260627-1
cd /tmp
dnf -y install kf6-kglobalaccel kf6-kdeclarative libplasma kf6-kio qt6-qtbase kf6-kguiaddons kf6-ki18n rpm-build
dnf -y install wayland-devel libdrm-devel kf6-kwindowsystem-devel plasma-workspace-devel libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel kwin-devel kwin-devel kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel kf6-kdeclarative-devel kdecoration-devel wayland-devel libdrm-devel
git clone https://github.com/4v3ngR/kwin-effects-glass --branch=$kwin_effects_glass_version
cd kwin-effects-glass
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make --jobs "$(nproc)"
cpack -V -G RPM
dnf install -y /tmp/kwin-effects-glass/build/kwin-glass.rpm
rm -rf /tmp/kwin-effects-glass

dnf -y remove wayland-devel libdrm-devel kf6-kwindowsystem-devel plasma-workspace-devel libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel kwin-devel kwin-devel kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel kf6-kdeclarative-devel kdecoration-devel wayland-devel libdrm-devel

dnf -y install \
  adw-gtk3-theme \
  ghostty \
  klassy \
  papirus-icon-theme

dnf -y remove \
  konsole

rm -f /etc/yum.repos.d/home:paulmcauley.repo
dnf -y copr disable ama1470/kwin-effects-glass
dnf -y copr disable scottames/ghostty

## plasmoids

# renovate: datasource=github-tags depName=peterfajdiga/karousel versioning=loose
karousel_version=0.17

cd /tmp
curl -fL -o /tmp/karousel.tar.gz https://github.com/peterfajdiga/karousel/releases/download/v$karousel_version/karousel_"${karousel_version/"."/"_"}".tar.gz
tar xzf /tmp/karousel.tar.gz
mkdir -p "/usr/share/kwin/scripts/karousel"
mv /tmp/karousel/* "/usr/share/kwin/scripts/karousel"

# plasma-panel-colorizer

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-colorizer versioning=loose
panel_colorizer_version=7.3.0
panel_colorizer_plasmoid=plasmoid-panel-colorizer-v$panel_colorizer_version.plasmoid

cd /tmp
curl -fL -o /tmp/pc.plasmoid https://github.com/luisbocanegra/plasma-panel-colorizer/releases/download/v$panel_colorizer_version/$panel_colorizer_plasmoid
unzip /tmp/pc.plasmoid -d /tmp/pc
mkdir -p "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"
mv /tmp/pc/* "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"

# plasma-panel-spacer-extended

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-spacer-extended versioning=loose
panelspacer_extended_version=1.16.0
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
