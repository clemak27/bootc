#!/usr/bin/env bash

set -euo pipefail

# enter container
if [ "$CONTAINER_ID" == "" ]; then
  echo "this needs to be run in a distrobox, e.g."
  echo "distrobox-ephemeral --image registry.fedoraproject.org/fedora-toolbox:44"
  exit 1
fi

sudo dnf -y install git cmake extra-cmake-modules gcc-g++ kf6-kwindowsystem-devel plasma-workspace-devel libplasma-devel qt6-qtbase-private-devel qt6-qtbase-devel cmake kwin-devel extra-cmake-modules kwin-devel kf6-knotifications-devel kf6-kio-devel kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel libepoxy-devel kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel kf6-kdeclarative-devel kdecoration-devel kf6-kglobalaccel kf6-kdeclarative libplasma kf6-kio qt6-qtbase kf6-kguiaddons kf6-ki18n wayland-devel libdrm-devel rpm-build

git clone https://github.com/4v3ngR/kwin-effects-glass
cd kwin-effects-glass
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j"$(nproc)"
cpack -V -G RPM

exit
# exit container && sudo rpm-ostree install kwin-effects-glass/build/kwin-glass.rpm
