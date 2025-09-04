#!/bin/bash

set -ouex pipefail

CONTEXT_PATH="$(realpath "$(dirname "$0")/..")" # should return /run/context
export CONTEXT_PATH

copy_systemfiles_for() {
	WHAT=$1
	shift
	DISPLAY_NAME=$WHAT
	if [ "${CUSTOM_NAME}" != "" ] ; then
		DISPLAY_NAME=$CUSTOM_NAME
	fi
	printf "::group:: ===%s-file-copying===\n" "${DISPLAY_NAME}"
	cp -avf "${CONTEXT_PATH}/$WHAT/." /
	printf "::endgroup::\n"
}

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

## Don't automatically start Steam
rm /etc/xdg/autostart/steam.desktop


# Copy system files
CUSTOM_NAME=
copy_systemfiles_for yapakipe_system_files

#####################################################################################
# Fix libvirtd not working after new install or after new deployment ######
#
# 1) Run 'yapakipe-post-update' with every 'ujust update'. This re-enables the libvirtd
#    service after rebooting - but only in cases where there isn't a new deployment.
sed -i '$ a\"Yapakipe post-update fixes" = "/usr/libexec/topgrade/yapakipe-post-update"' /etc/ublue-os/topgrade.toml
#
# 2) For new deployments, let's create the service file link here for the service that
#    restarts libvirtd.
ln -s /usr/lib/systemd/system/bazzite-libvirtd-setup.service /etc/systemd/system/multi-user.target.wants/bazzite-libvirtd-setup.service
#
#####################################################################################