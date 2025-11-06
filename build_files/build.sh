#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/42/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 install -y libffi-devel libyaml-devel \
  chafa flac fscrypt fuse-sshfs fuse-zip sshfs vifm \
  gwenview mako niri okular qutebrowser

# Zellij
dnf5 -y copr enable varlad/zellij
dnf5 -y install zellij
dnf5 -y copr disable varlad/zellij

#### Example for enabling a System Unit File

# systemctl enable podman.socket
