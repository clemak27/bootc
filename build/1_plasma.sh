#!/bin/bash

set -ouex pipefail

dnf -y install git cmake extra-cmake-modules gettext

# klassy

# renovate: datasource=github-tags depName=paulmcauley/klassy versioning=loose
klassy_version=6.4.breeze6.4.0

cd /tmp
dnf -y install "cmake(KF5Config)" "cmake(KF5CoreAddons)" "cmake(KF5FrameworkIntegration)" "cmake(KF5GuiAddons)" "cmake(KF5Kirigami2)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(Qt5DBus)" "cmake(Qt5Quick)" "cmake(Qt5Widgets)" "cmake(Qt5X11Extras)" "cmake(KDecoration3)" "cmake(KF6ColorScheme)" "cmake(KF6Config)" "cmake(KF6CoreAddons)" "cmake(KF6FrameworkIntegration)" "cmake(KF6GuiAddons)" "cmake(KF6I18n)" "cmake(KF6KCMUtils)" "cmake(KF6KirigamiPlatform)" "cmake(KF6WindowSystem)" "cmake(Qt6Core)" "cmake(Qt6DBus)" "cmake(Qt6Quick)" "cmake(Qt6Svg)" "cmake(Qt6Widgets)" "cmake(Qt6Xml)"
git clone https://github.com/paulmcauley/klassy --branch=$klassy_version
cd klassy
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make --jobs "$(nproc)"
make install

# kwin-effects-glass

# renovate: datasource=github-tags depName=4v3ngR/kwin-effects-glass versioning=loose
kwin_effects_glass_version=1.6.3
cd /tmp
dnf -y install kf6-kglobalaccel kf6-kdeclarative libplasma kf6-kio qt6-qtbase kf6-kguiaddons kf6-ki18n rpm-build
dnf -y install wayland-devel libdrm-devel kf6-kwindowsystem-devel plasma-workspace-devel libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel kwin-devel kwin-devel kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel kf6-kdeclarative-devel kdecoration-devel wayland-devel libdrm-devel
git clone https://github.com/4v3ngR/kwin-effects-glass --branch=v$kwin_effects_glass_version
cd kwin-effects-glass
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make --jobs "$(nproc)"
cpack -V -G RPM
dnf install -y /tmp/kwin-effects-glass/build/kwin-glass.rpm
rm -rf /tmp/kwin-effects-glass

dnf -y remove wayland-devel libdrm-devel kf6-kwindowsystem-devel plasma-workspace-devel libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel kwin-devel kwin-devel kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel kf6-kdeclarative-devel kdecoration-devel wayland-devel libdrm-devel

# kara

# renovate: datasource=github-tags depName=dhruv8sh/kara versioning=loose
kara_version=0.8.0

cd /tmp
curl -fL -o /tmp/kara.tar.gz https://github.com/dhruv8sh/kara/archive/refs/tags/v$kara_version.tar.gz
tar xzf kara.tar.gz
mkdir -p "/usr/share/plasma/plasmoids"
mv kara-$kara_version "/usr/share/plasma/plasmoids/org.dhruv8sh.kara"

# krohnkite

# renovate: datasource=forgejo-tags depName=anametologin/Krohnkite versioning=loose registryUrl=https://codeberg.org
krohnkite_version=0.9.9.2

cd /tmp
curl -fL -o /tmp/krohnkite.kwinscript https://github.com/anametologin/krohnkite/releases/download/$krohnkite_version/krohnkite.kwinscript
unzip /tmp/krohnkite.kwinscript -d /tmp/krohnkite
mkdir -p "/usr/share/kwin/scripts/krohnkite"
mv /tmp/krohnkite/* "/usr/share/kwin/scripts/krohnkite"

# plasma-panel-colorizer

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-colorizer versioning=loose
panel_colorizer_version=6.5.0
panel_colorizer_plasmoid=plasmoid-panel-colorizer-v$panel_colorizer_version.plasmoid

cd /tmp
curl -fL -o /tmp/pc.plasmoid https://github.com/luisbocanegra/plasma-panel-colorizer/releases/download/v$panel_colorizer_version/$panel_colorizer_plasmoid
unzip /tmp/pc.plasmoid -d /tmp/pc
mkdir -p "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"
mv /tmp/pc/* "/usr/share/plasma/plasmoids/luisbocanegra.panel.colorizer"

# plasma-panel-spacer-extended

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-spacer-extended versioning=loose
panelspacer_extended_version=1.12.0
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
