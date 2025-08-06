#!/bin/bash

set -ouex pipefail

IMAGE_NAME="Bazzite-DX-yapakipe"
IMAGE_PRETTY_NAME="Bazzite-DX Yapakipe (FROM Bazzite-DX)"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y \
    gparted

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File
#systemctl enable podman.socket

# Modify OS Release File 
sed -i "s/^VARIANT_ID=.*/VARIANT_ID=$IMAGE_NAME/" /usr/lib/os-release
sed -i "s/^PRETTY_NAME=.*/PRETTY_NAME=\"$IMAGE_PRETTY_NAME\"/" /usr/lib/os-release
sed -i "s/^NAME=.*/NAME=\"$IMAGE_NAME\"/" /usr/lib/os-release

./99-build-initramfs.sh

./999-cleanup.sh