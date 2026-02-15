#!/bin/bash

set -eoux pipefail

###############################################################################
# Replace the GNOME desktop environment with System76's COSMIC desktop from
# their COPR repository.
#
# COSMIC is a new desktop environment built in Rust by System76.
# https://github.com/pop-os/cosmic-epoch
###############################################################################

# Source helper functions
# shellcheck source=/dev/null
source /ctx/copr-helpers.sh

# Remove GNOME Shell and related packages
dnf5 remove -y \
    gnome-shell \
    gnome-shell-extension* \
    gnome-terminal \
    gnome-software \
    gnome-control-center \
    nautilus \
    gdm

# Install COSMIC desktop from System76's COPR
# Using isolated pattern to prevent COPR from persisting
copr_install_isolated "ryanabx/cosmic-epoch" \
    cosmic-session \
    cosmic-greeter \
    cosmic-comp \
    cosmic-panel \
    cosmic-launcher \
    cosmic-applets \
    cosmic-settings \
    cosmic-files \
    cosmic-edit \
    cosmic-term \
    cosmic-workspaces

echo "COSMIC desktop installed successfully"

# Enable cosmic-greeter (COSMIC's display manager)
systemctl enable cosmic-greeter

# Set COSMIC as default session
mkdir -p /etc/X11/sessions
cat > /etc/X11/sessions/cosmic.desktop << 'COSMICDESKTOP'
[Desktop Entry]
Name=COSMIC
Comment=COSMIC Desktop Environment
Exec=cosmic-session
Type=Application
DesktopNames=COSMIC
COSMICDESKTOP

echo "Display manager configured"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# packages from fedora repos
dnf5 install -y libffi-devel libicu74 libjpeg-turbo-devel libyaml-devel openssl-devel \
  kitty flatpak xdg-desktop-portal-cosmic \
  chafa flac fscrypt fuse-sshfs fuse-zip sshfs tmux vifm \
  gwenview okular qutebrowser

# Ghostty - https://ghostty.org/
copr_install_isolated "scottames/ghostty" ghostty

# Zellij - https://zellij.dev/
copr_install_isolated "varlad/zellij" zellij
