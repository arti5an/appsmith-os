#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 install -y libffi-devel libicu74 libjpeg-turbo-devel libyaml-devel mate-polkit \
  chafa flac fscrypt fuse-sshfs fuse-zip sshfs vifm \
  gwenview mako okular qutebrowser

# Ghostty - https://ghostty.org/
dnf5 -y copr enable scottames/ghostty
dnf5 -y install ghostty
dnf5 -y copr disable scottames/ghostty

# Zellij - https://zellij.dev/
dnf5 -y copr enable varlad/zellij
dnf5 -y install zellij
dnf5 -y copr disable varlad/zellij

# DankMaterialShell - https://danklinux.com/
dnf5 -y copr enable avengemedia/dms
dnf5 -y install dms dms-greeter niri
dnf5 -y copr disable avengemedia/dms
dnf5 -y copr enable avengemedia/danklinux
dnf5 -y install dgop dsearch
dnf5 -y copr disable avengemedia/danklinux

#### Example for enabling a System Unit File

# systemctl disable gdm.service
# systemctl enable greetd.service
